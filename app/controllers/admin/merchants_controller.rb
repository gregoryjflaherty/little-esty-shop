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
    @merchant = Merchant.find(params[:id])
    
    if merchant_params[:status]
      @merchant.change_enabled_status(params[:status])
      redirect_to admin_merchants_path
    else
      @merchant.update!(merchant_params)
      redirect_to admin_merchant_path(merchant),  notice: "Merchant Successfully Updated"
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end
