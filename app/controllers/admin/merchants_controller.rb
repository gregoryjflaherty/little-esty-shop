class Admin::MerchantsController < AdminController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
     @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:disable]
      merchant.update(status: params[:disable].to_i)
      redirect_to admin_merchants_path
    elsif params[:enable]
      merchant.update(status: params[:enable].to_i)
      redirect_to admin_merchants_path
    else
      @merchant = Merchant.find(params[:id])
      @merchant.update!(merchant_params)
      redirect_to admin_merchant_path(@merchant),  notice: "Merchant Successfully Updated"
    end 
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
