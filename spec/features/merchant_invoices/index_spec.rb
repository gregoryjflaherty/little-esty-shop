require 'rails_helper'

RSpec.describe 'merchant invoices index' do
  before(:each) do
    @nike = Merchant.create!(name: "Nike")

     @shoe_1 = Item.create(name: 'running shoe', description: 'shoe for running', unit_price: 100, merchant_id: @nike.id)

    @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )
    @customer_2 = Customer.create!(first_name: 'Two',last_name:'Customer' )
    @customer_3 = Customer.create!(first_name: 'Three' ,last_name:'Customer' )

    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create(customer_id: @customer_2.id, status: 1)
    @invoice_3 = Invoice.create(customer_id: @customer_3.id, status: 1)

    @invoice_item_1 = InvoiceItem.create(quantity: 2, unit_price: 100, invoice_id: @invoice_1.id, item_id: @shoe_1.id, status: 2)
    @invoice_item_2 = InvoiceItem.create(quantity: 2, unit_price: 100, invoice_id: @invoice_2.id, item_id: @shoe_1.id, status: 1)
    @invoice_item_3 = InvoiceItem.create(quantity: 2, unit_price: 100, invoice_id: @invoice_3.id, item_id: @shoe_1.id, status: 1)

    visit merchant_invoices_path(@nike)
  end


  it 'shows all invoices that include at least one of merchant items' do
    expect(page).to have_link("#{@invoice_1.id}")
    expect(page).to have_link("#{@invoice_2.id}")
    expect(page).to have_link("#{@invoice_3.id}")

    click_link("#{@invoice_1.id}")
    expect(current_path).to eq(merchant_invoice_path(@nike.id, @invoice_1.id))
  end
end
