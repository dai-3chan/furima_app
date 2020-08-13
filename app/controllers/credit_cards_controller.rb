class CreditCardsController < ApplicationController
  before_action :logged_in?, only: [:new, :add, :show, :delete]

  require 'payjp'

  def new
    user_card = CreditCard.where(user_id: current_user.id)
    redirect_to action: "show" if user_card.exists?
  end

  def add
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: '登録',
        email: current_user.email, 
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
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id) # customer_idを利用して情報を取得する。
      @default_card_information = customer.cards.retrieve(card.card_id) 
    
    end
  end

  def delete
    card = CreditCard.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id) #cutomer_idを利用して情報を取得する。
      customer.delete #削除
      card.delete
    end
      redirect_to action: "new"
  end
end
