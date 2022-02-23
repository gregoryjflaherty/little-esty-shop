require 'rails_helper'

RSpec.describe 'User story 38' do
  before(:each) do
    @nike = Merchant.create!(name: "Nike")

    @shoe_1 = Item.create(name: 'shoe_1', merchant_id: @nike.id)

    @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )
    @customer_2 = Customer.create!(first_name: 'Two',last_name:'Customer' )
    @customer_3 = Customer.create!(first_name: 'Three' ,last_name:'Customer' )
    @customer_4 = Customer.create!(first_name: 'Four',last_name:'Customer' )
    @customer_5 = Customer.create!(first_name: 'Five',last_name:'Customer' )
    @customer_6 = Customer.create!(first_name: 'Six',last_name:'Customer' )

    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create(customer_id: @customer_2.id, status: 1)
    @invoice_3 = Invoice.create(customer_id: @customer_3.id, status: 1)
    @invoice_4 = Invoice.create(customer_id: @customer_4.id, status: 1)
    @invoice_5 = Invoice.create(customer_id: @customer_5.id, status: 1)
    @invoice_6 = Invoice.create(customer_id: @customer_6.id, status: 1)

    @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_1.id, status: 2)
    @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_1.id, status: 1)
    @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @shoe_1.id, status: 1)
    @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @shoe_1.id, status: 1)
    @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @shoe_1.id, status: 1)
    @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @shoe_1.id, status: 1)


    @transaction_1 = Transaction.create(invoice_id: @invoice_item_1.invoice.id, result: 0)
    @transaction_2 = Transaction.create(invoice_id: @invoice_item_2.invoice.id, result: 1)
    @transaction_3 = Transaction.create(invoice_id: @invoice_item_3.invoice.id, result: 1)
    @transaction_4 = Transaction.create(invoice_id: @invoice_item_4.invoice.id, result: 1)
    @transaction_5 = Transaction.create(invoice_id: @invoice_item_5.invoice.id, result: 1)
    @transaction_6 = Transaction.create(invoice_id: @invoice_item_6.invoice.id, result: 1)


    visit merchant_dashboard_index_path(@nike)
  end

  it 'shows top 5 customers ' do
    expect(page).to have_content('Top Customers')

    within '#customer-0' do
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content(1)
    end

    within '#customer-1' do
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content(1)
    end

    within '#customer-2' do
      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_4.last_name)
      expect(page).to have_content(1)
    end

    within '#customer-3' do
      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_5.last_name)
      expect(page).to have_content(1)
    end

    within '#customer-4' do
      expect(page).to have_content(@customer_6.first_name)
      expect(page).to have_content(@customer_6.last_name)
      expect(page).to have_content(1)
    end
  end

  it 'shows every merchant' do
    expect(page).to have_content(@nike.name)
  end

  describe 'User Story 39' do
    it 'shows a link to merchant items and merchant invoices' do

      expect(page).to have_content("Invoices")
      click_link "Invoices"
      expect(current_path).to eq("/merchants/#{@nike.id}/invoices")

    end

    it 'shows a link to merchant items and merchant items' do

      expect(page).to have_content("Items")
      click_link "Items"
      expect(current_path).to eq("/merchants/#{@nike.id}/items")
    end
  end

  describe 'items ready to ship' do
    it 'shows section for items ready to ship with names of items not yet shipped' do
      expect(page).to have_content("Items Ready to Ship")
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d,%Y"))
      expect(page).to have_content(@invoice_2.created_at.strftime("%A, %B %d,%Y"))
      expect(page).to have_content(@invoice_3.created_at.strftime("%A, %B %d,%Y"))
      expect(page).to have_content(@invoice_4.created_at.strftime("%A, %B %d,%Y"))
      expect(page).to have_content(@invoice_5.created_at.strftime("%A, %B %d,%Y"))
    end
  end
end
