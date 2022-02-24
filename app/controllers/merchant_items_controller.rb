class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create

  end

  def new

  end

  def edit

  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if params[:enabled]
      @item.change_enabled_status(params[:enabled])
      redirect_to "/merchants/#{params[:merchant_id]}/items"
    end
  end

  def destroy

  end
end
