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

  describe 'User story 34' do
    before(:each) do
      @merchant1 = Merchant.create!(name: "Pabu")
      @merchant2 = Merchant.create!(name: "Loki")
      @item1 = @merchant1.items.create!(name: "Ferret Food", unit_price: 20)
      @item2 = @merchant1.items.create!(name: "Ferret Leash", unit_price: 20)
      @item3 = @merchant2.items.create!(name: "Ferret Shampoo", unit_price: 20)
    end

    it 'item name on index page goes to item show page' do

      visit merchant_items_path(@merchant1)

      click_link "#{@item1.name}"

      expect(page).to have_current_path(merchant_item_path(@merchant1, @item1))
    end

    it 'shows every items attributes' do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
    end
  end

  describe 'User story 33' do
    before(:each) do
      @merchant1 = Merchant.create!(name: "Pabu")
      @merchant2 = Merchant.create!(name: "Loki")
      @item1 = @merchant1.items.create!(name: "Ferret Food", unit_price: 20)
      @item2 = @merchant1.items.create!(name: "Ferret Leash", unit_price: 20)
      @item3 = @merchant2.items.create!(name: "Ferret Shampoo", unit_price: 20)
    end

    it 'item name on index page goes to item show page' do
      visit "/merchants/#{@merchant1.id}/#{@item1.id}"

      click_link "update item"

      expect(page).to have_current_path("/merchants/#{@merchant1.id}/#{@item1.id}/update")


      expect(page).to have_content("Update Item")

      fill_in "Name" with: ""
      fill_in "Description" with: ""
      fill_in "Current unit price" with: ""

      click_button "Submit"

      expect(page).to have_current_path("/merchants/#{@merchant1.id}/#{@item1.id}")

      #flash message saying info updated
      flash[:alert] = ""


    end
  end
end
