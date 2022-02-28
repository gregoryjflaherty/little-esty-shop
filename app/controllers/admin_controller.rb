class AdminController < ApplicationController
  def index
    @customers = Customer.all
    @invoices = Invoice.oldest_to_newest
  end
end
