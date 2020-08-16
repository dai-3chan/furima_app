class CreditCardsController < ApplicationController
  before_action :logged_in?, only: [:new, :add, :show, :delete]
  before_action :get_card, only: [:new ,:delete, :show]
  before_action :card_info, only: [:delete, :show]

  require 'payjp'

  def new
    redirect_to action: "show" unless @card.nil?
  end

  def add
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: '登録',
        # email: current_user.email, 
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "add"
      end
    end
  end

  def show
    @default_card_information = @customer.cards.retrieve(@card.card_id)
  end

  def delete
    @customer.delete #削除
    @card.delete
    redirect_to action: "new"
  end

  private
  def get_card
    @card = CreditCard.find_by(user_id: current_user.id)
  end

  def card_info  # payjpに顧客の情報(カードを問いあわせる)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      @customer = Payjp::Customer.retrieve(@card.customer_id) # customer_idを利用して情報を取得する。
    end
  end
end
