class ItemsController < ApplicationController
  def index
  end

  def destroy
    items = Item.find(params[:id])
    item.destroy
  end

end
