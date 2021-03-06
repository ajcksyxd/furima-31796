class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :search_item, only: [:index, :search]

  def index
    @items = Item.all.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user).order('created_at DESC')
  end

  def edit
    redirect_to action: :index unless @item.user_id == current_user.id && @item.purchase.nil?
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render 'edit'
    end
  end

  def destroy
    if user_signed_in? && @item.user_id == current_user.id
      @item.destroy
      redirect_to root_path
    else
      render 'show'
    end
  end

  def search
    @results = @q.result
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :days_to_ship_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def search_item
    @q = Item.ransack(params[:q])
  end
end
