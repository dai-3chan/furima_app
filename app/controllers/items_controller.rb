class ItemsController < ApplicationController
  before_action :set_item, only: [:show]
  
  def index
    @new_items = Item.where(status_id: 1).order(id: "DESC").limit(5)
  end

  def show 
    @related_items = Item.where(category_id: params[:category_id]).limit(3)
  end
  
  def new
    @item = Item.new
    @brand = Brand.new
    @item.images.new

    @category_parent_array = ["---"]
    #Categoryデータベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array + Category.where(ancestry: nil).pluck(:name)         
    @items = Item.includes(:images).order("created_at DESC")
  end
  
  def create
    @brand = Brand.create(brand_params)
    @item = Item.new(item_params)

    if @item.save!
      redirect_to items_path, notice: "出品が完了しました"
    else
      @item = Item.new(item_params)
      flash.now[:alert] = "no"
      redirect_to new_item_path, alert: "必須項目は全て入力してください"
    end
  end
  
  def update
  end
  
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children

  end

  # 子カテゴリーが選択された後に呼び出されるアクション
  def get_category_grandchildren
    @key = params[:child_id].to_i
    @category_grandchildren = Category.find(@key).children
  end
    
  private 

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to items_path, notice: "商品を削除しました"
    else
      flash.now[:alert] = "削除できませんでした"
    end
  end

  def edit

  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :item_condition_id, :delivery_cost_id, :seller_region_id, :preparation_for_shipment_id, :price, images_attributes: [:image_url]).merge(seller_id: current_user.id, user_id: current_user.id, status_id:1, brand_id: @brand.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

  def brand_params
    params.require(:item).permit(:brand_name)  
  end
end

#brandsテーブルに保存してからitemsテーブルに保存する。
