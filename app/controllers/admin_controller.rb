class AdminController < ApplicationController
  def index

    @invoices = Invoice.oldest_to_newest
    @customers = Customer.all
  end
end
