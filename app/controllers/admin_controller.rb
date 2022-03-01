class AdminController < ApplicationController
  def index
    @customers = Customer.all
    @invoice = Invoice.all
    @invoices = Invoice.oldest_to_newest
  end
end
