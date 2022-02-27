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

  describe '#us20' do
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
      @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_4 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_5 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_6 = Invoice.create(customer_id: @customer_2.id, status: 1)
      @invoice_7 = Invoice.create(customer_id: @customer_2.id, status: 1)
      @invoice_8 = Invoice.create(customer_id: @customer_2.id, status: 1)
      @invoice_9 = Invoice.create(customer_id: @customer_2.id, status: 1)
      @invoice_10 = Invoice.create(customer_id: @customer_3.id, status: 1)
      @invoice_11 = Invoice.create(customer_id: @customer_3.id, status: 1)
      @invoice_12 = Invoice.create(customer_id: @customer_3.id, status: 1)
      @invoice_13 = Invoice.create(customer_id: @customer_4.id, status: 1)
      @invoice_14 = Invoice.create(customer_id: @customer_4.id, status: 1)
      @invoice_15 = Invoice.create(customer_id: @customer_5.id, status: 1)

      @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_1.id, status: 2)
      @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_7 = InvoiceItem.create(invoice_id: @invoice_7.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_8 = InvoiceItem.create(invoice_id: @invoice_8.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_9 = InvoiceItem.create(invoice_id: @invoice_9.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_10 = InvoiceItem.create(invoice_id: @invoice_10.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_11 = InvoiceItem.create(invoice_id: @invoice_11.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_12 = InvoiceItem.create(invoice_id: @invoice_12.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_13 = InvoiceItem.create(invoice_id: @invoice_13.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_14 = InvoiceItem.create(invoice_id: @invoice_14.id, item_id: @shoe_1.id, status: 1)
      @invoice_item_15 = InvoiceItem.create(invoice_id: @invoice_15.id, item_id: @shoe_1.id, status: 1)


      @transaction_1 = Transaction.create(invoice_id: @invoice_item_1.invoice.id, result: 0)
      @transaction_2 = Transaction.create(invoice_id: @invoice_item_2.invoice.id, result: 1)
      @transaction_3 = Transaction.create(invoice_id: @invoice_item_3.invoice.id, result: 1)
      @transaction_4 = Transaction.create(invoice_id: @invoice_item_4.invoice.id, result: 1)
      @transaction_5 = Transaction.create(invoice_id: @invoice_item_5.invoice.id, result: 1)
      @transaction_6 = Transaction.create(invoice_id: @invoice_item_6.invoice.id, result: 1)
      @transaction_7 = Transaction.create(invoice_id: @invoice_item_7.invoice.id, result: 1)
      @transaction_8 = Transaction.create(invoice_id: @invoice_item_8.invoice.id, result: 1)
      @transaction_9 = Transaction.create(invoice_id: @invoice_item_9.invoice.id, result: 1)
      @transaction_10 = Transaction.create(invoice_id: @invoice_item_10.invoice.id, result: 1)
      @transaction_11 = Transaction.create(invoice_id: @invoice_item_11.invoice.id, result: 1)
      @transaction_12 = Transaction.create(invoice_id: @invoice_item_12.invoice.id, result: 1)
      @transaction_13 = Transaction.create(invoice_id: @invoice_item_13.invoice.id, result: 1)
      @transaction_14 = Transaction.create(invoice_id: @invoice_item_14.invoice.id, result: 1)
      @transaction_15 = Transaction.create(invoice_id: @invoice_item_15.invoice.id, result: 1)
    end

    it 'shows the names of the top 5 customers ' do

      visit "/admin"
      expect(page).to have_content("Top 5 Customers")

      within "div.top_five_customers" do
        expect('One Customer').to appear_before('Two Customer')
        expect('Two Customer').to appear_before('Three Customer')
        expect('Three Customer').to appear_before('Four Customer')
        expect('Four Customer').to appear_before('Five Customer')
        expect(page).to have_content("One Customer with 5 completed transactions")
        expect(page).to have_content("Two Customer with 4 completed transactions")
      end
    end
  end
end
