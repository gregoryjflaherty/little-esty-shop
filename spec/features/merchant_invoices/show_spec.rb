require 'rails_helper'

RSpec.describe 'merchant invoice show page' do

  before(:each) do
    @nike = Merchant.create!(name: "Nike")

    @shoe_1 = Item.create(name: 'running shoe', description: 'shoe for running', unit_price: 100, merchant_id: @nike.id)
    @shoe_2 = Item.create(name: 'trail running shoe', description: 'shoe for running on trails', unit_price: 200, merchant_id: @nike.id)

    @customer_1 = Customer.create!(first_name: 'Bob',last_name:'Vance' )

    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 1)
    
    @invoice_item_1 = InvoiceItem.create(quantity: 2, unit_price: 100, invoice_id: @invoice_1.id, item_id: @shoe_1.id, status: 2)
    @invoice_item_2 = InvoiceItem.create(quantity: 2, unit_price: 200, invoice_id: @invoice_2.id, item_id: @shoe_2.id, status: 1)

    visit merchant_invoice_path(@nike.id, @invoice_1.id)
  end 

  it 'shows info related to that invoice' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end

  it 'shows invoice #created_at date formatted in DAY, MM DD, YYYY' do
    expect(page).to have_content(@invoice_1.creation_date_formatted)
  end

  it 'shows invoice item attributes only for that invoice' do
    expect(page).to have_content(@shoe_1.name)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.status)
    expect(page).to_not have_content(@shoe_2.name)
  end
end