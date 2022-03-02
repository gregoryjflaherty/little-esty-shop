require 'rails_helper'

RSpec.describe 'admin_invoices show page' do
  before(:each) do
    @nike = Merchant.create!(name: "Nike")

    @af_one = @nike.items.create!(name: "Air Force One", unit_price: 12000)
    @boot = @nike.items.create!(name: "Nike Boot", unit_price: 20000)

    @customer_1 = Customer.create!(first_name:'Fake',last_name:'Customer' )

    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: '2022-01-01')

    @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @af_one.id, status: 2, unit_price: 12000, quantity: 1)
    @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @boot.id, status: 1, unit_price: 20000, quantity: 1)
  end

  describe 'User Story 8' do
    it 'goes to invoice show page which include id, status, created_at, and full name' do
      visit admin_invoice_path(@invoice_1)
      expect(current_path).to eq(admin_invoice_path(@invoice_1))

      expect(page).to have_content("Invoice: #{@invoice_1.id}")
      expect(page).to have_content("Invoice status: #{@invoice_1.status}")
      expect(page).to have_content("Created at: #{@invoice_1.creation_date_formatted}")
      expect(page).to have_content("For: #{@customer_1.full_name}")
    end
  end


  describe 'User Story 7' do
    it 'invoice show shows all items on invoice including name, quantity, price & invoice_item status' do
      visit admin_invoice_path(@invoice_1)
      expect(current_path).to eq(admin_invoice_path(@invoice_1))
      within "div.items" do
        save_and_open_page
        expect(page).to have_content("Items on Invoice:")
        expect(page).to have_content("#{@af_one.name}")
        expect(page).to have_content("Price: #{@invoice_item_1.unit_price}")
        expect(page).to have_content("Quantity: #{@invoice_item_1.quantity}")
        expect(page).to have_content("Status: #{@invoice_item_1.status}")
      end
    end
  end

  describe 'User Story 8' do
    it 'shows total revenue for invoice' do
      visit admin_invoice_path(@invoice_1)
      save_and_open_page
      expect(current_path).to eq(admin_invoice_path(@invoice_1))

      expect(page).to have_content("Total revenue: 320.00")
    end
  end
end
