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
    if params[:status]
      @merchant.change_enabled_status(params[:status])
      redirect_to admin_merchants_path
    else
      @merchant.update!(merchant_params)
      redirect_to admin_merchant_path(@merchant),  notice: "Merchant Successfully Updated"
    end
  end

  private
  def merchant_params
    params.permit(:name, :status)
  end
end
