class UsersController < ApplicationController
  before_action :logged_in?, only: [:purchased, :sold, :selling] 
  def show
  end

  def purchased
    @purchased_items = Item.where(buyer_id: current_user.id) # 自身が購入した商品を取得
  end

  def sold
    @sold_items = Item.where(seller_id: current_user.id, status_id: 2)  # 自身が出品し、ユーザーに購入された商品を取得
  end

  def selling
    @selling_items = Item.where(seller_id: current_user.id, status_id: 1) # 自身が出品中の商品を取得
  end
end
