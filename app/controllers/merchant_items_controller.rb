class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create

  end

  def new

  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
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
    else
      @merchant = Merchant.find(params[:merchant_id])
      @item = Item.find(params[:id])
      @item.update({
        name: params[:name],
        description: params[:description],
        unit_price: params[:unit_price]
        })

      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"

      flash[:alert] = "Item has been updated"
    end 
  end

  def destroy

  end
end
