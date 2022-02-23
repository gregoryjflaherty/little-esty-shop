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
    item = Item.find(params[:item_id])
    item.update({
      name: params[:name],
      description: params[:description],
      unit_price: params[:unit_price]
      })

    redirect_to "/merchants/#{@merchant1.id}/#{@item1.id}"

    flash[:alert] = "Item info has been updated"
  end

  def destroy

  end
end
