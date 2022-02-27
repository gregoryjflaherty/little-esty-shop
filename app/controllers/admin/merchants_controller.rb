class Admin::MerchantsController < AdminController
  def index
    @merchants = Merchant.all
  end
end
