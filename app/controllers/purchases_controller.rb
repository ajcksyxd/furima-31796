class PurchasesController < ApplicationController
  def index
    @purchase_address = PurchaseAddress.new
    @item = Item.find_by(id: params[:item_id])
  end

  def create
  end
end
