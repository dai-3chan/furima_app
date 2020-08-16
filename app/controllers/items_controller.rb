class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :edit]

  def index
    @new_items = Item.where(status_id: 1).order(id: "DESC").limit(5)
  end

  def show
    @related_items = Item.where(category_id: params[:category_id]).limit(3)
  end

  def new
    @item = Item.new
    @brand = Brand.new
    @item.build_brand
    @item.images.new

    # @category_parent_array = ["---"]
    #Categoryデータベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
    @items = Item.includes(:images).order("created_at DESC")
  end

  def create
    @item = Item.new(item_params)
    @brand = Brand.new(brand_params)
    @category_parent_array = Category.where(ancestry: nil)
    if @item.save
      redirect_to root_path, notice: "出品が完了しました"
    elsif @item.images.length > 10 || @item.images.length == 0
      redirect_to new_item_path, alert: "画像は1~10枚にしてください"
    elsif @item.name.length == 0 || @item.name.length > 40
      flash.now[:alert] = "名前は1~40文字で入力してください"
      render action: :new
    elsif @item.description.length == 0 || @item.description.length > 1000
      flash.now[:alert] = "商品説明は1~1000文字で入力してください"
      render action: :new
    else
      flash.now[:alert] = "必須項目は全て入力してください"
      render action: :new
    end
  end

  def update

    if @item.update(item_params) && @item.user_id == current_user.id
      redirect_to edit_item_path, notice: "更新しました"
    elsif @item.images.length > 10 || @item.images.length == 0
      redirect_to edit_item_path, alert: "画像は1~10枚にしてください"
    elsif @item.name.length == 0 || @item.name.length > 40
      flash.now[:alert] = "名前は1~40文字で入力してください"
      render action: :edit
    elsif @item.description.length == 0 || @item.description.length > 1000
      flash.now[:alert] = "商品説明は1~1000文字で入力してください"
      render action: :edit
    else
      flash.now[:alert] = "必須項目は全て入力してください"
      render action: :edit
    end
  end

  def edit
    @item.images.build
    @brand = Brand.new
    @item.build_brand
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


  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to items_path, notice: "商品を削除しました"
    else
      flash.now[:alert] = "削除できませんでした"
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :brand_id, :item_condition_id, :delivery_cost_id, :seller_region_id, :preparation_for_shipment_id, :price, images_attributes: [:image_url, :_destroy, :id], brand_attributes:[:brand_name, :id]).merge(seller_id: current_user.id, user_id: current_user.id, status_id:1)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def brand_params
    params.require(:item).permit(:brand_name)
  end
end

#brandsテーブルに保存してからitemsテーブルに保存する。
