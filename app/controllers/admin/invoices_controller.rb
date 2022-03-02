class Admin::InvoicesController < AdminController
  def index

  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
