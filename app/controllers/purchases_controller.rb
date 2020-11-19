class PurchasesController < ApplicationController
  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
  end
end
