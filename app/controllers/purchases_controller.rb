class PurchasesController < ApplicationController
  before_action :set_item, only: [:confirmation, :pay]
  before_action :logged_in?, only: [:confirmation, :pay]
  before_action :card_holder?, only: [:confirmation, :pay]
  before_action :out_of_stock?, only: [:confirmation, :pay]
  before_action :set_card, only: [:confirmation, :pay]

  require 'payjp'

  def confirmation
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "credit_cards", action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
      amount: @item.price, #支払金額を入力
      customer: @card.customer_id, #顧客ID
      currency: 'jpy', #日本円
    )
    @item.buyer_id = current_user.id #Itemsテーブルのseller_idカラムにログインユーザー（購入者のID）入力する
    @item.status_id = 2  #Itemsテーブルのstatusカラムを売却済(2)にステータスを変える
    @item.save
    redirect_to controller: "items", action: "index", notice: "支払いが完了しました"
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_card
    @card = CreditCard.find_by(user_id: current_user.id)
  end
  # 二重購入の禁止
  def out_of_stock?
    redirect_to @item if @item.status_id == 2
  end
end
