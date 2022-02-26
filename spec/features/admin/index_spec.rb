require 'rails_helper'

RSpec.describe 'Admin Index' do
  before(:each) do
    @nike = Merchant.create(name: "Nike")

    @shoe_1 = Item.create(name: 'shoe_1', merchant_id: @nike.id)
    @shoe_2 = Item.create(name: 'shoe_2', merchant_id: @nike.id)
    @shoe_3 = Item.create(name: 'shoe_3', merchant_id: @nike.id)
    @shoe_4 = Item.create(name: 'shoe_4', merchant_id: @nike.id)
    @shoe_5 = Item.create(name: 'shoe_5', merchant_id: @nike.id)
    @shoe_6 = Item.create(name: 'shoe_6', merchant_id: @nike.id)

    @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )
    @customer_2 = Customer.create!(first_name: 'Two',last_name:'Customer' )

    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 1)
    @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 1)
    @invoice_4 = Invoice.create(customer_id: @customer_2.id, status: 1)
    @invoice_5 = Invoice.create(customer_id: @customer_2.id, status: 1)
    @invoice_6 = Invoice.create(customer_id: @customer_2.id, status: 1)

    @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_1.id, status: 2)
    @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_2.id, status: 2)
    @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_3.id, status: 2)
    @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_4.id, status: 1)
    @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_5.id, status: 1)
    @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_6.id, status: 1)
  end

  describe '#us22' do
    it 'It shows Admin Header' do
      visit '/admin/'

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'US 21' do
    it 'has links to merchant index' do
      visit '/admin/'
      expect(page).to have_link("All Merchants")

      click_on "All Merchants"
      expect(current_path).to eq('/admin/merchants')
    end

    it 'has links to invoices index' do
      visit '/admin/'
      expect(page).to have_link("All Invoices")

      click_on "All Invoices"
      expect(current_path).to eq('/admin/invoices')
    end
  end

  describe 'US 19' do
    describe 'has section that shows incomplete invoices with link to that invoice page' do
      it 'has a section for Incomplete invoices' do
        visit admin_index_path
        expect(current_path).to eq(admin_index_path)

        expect(page).to have_content("Incomplete Invoices")
      end

      it 'lists all incomplete invoices' do
        visit admin_index_path
        expect(current_path).to eq(admin_index_path)


        expect(page).to have_link("Invoice #{@invoice_2.id}")
        expect(page).to_not have_link("Invoice #{@invoice_1.id}")
      end

      it 'links to admin invoice show page' do
        visit admin_index_path
        expect(current_path).to eq(admin_index_path)

        click_on "Invoice #{@invoice_2.id}"
        expect(current_path).to eq(admin_invoices_path(@invoice_2))
      end
    end
  end
end
