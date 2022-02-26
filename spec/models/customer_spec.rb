require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it {should have_many(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:invoice_items).through(:invoices)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
  end

  describe 'instance methods' do
    describe '#successful_transactions' do
      it 'returns the count of successful transactions' do
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
        @invoice_5 = Invoice.create(customer_id: @customer_2.id, status: 1)
        @invoice_6 = Invoice.create(customer_id: @customer_2.id, status: 1)

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

        expect(@customer_1.successful_transactions_count).to eq 4
        expect(@customer_2.successful_transactions_count).to eq 2
        expect(@customer_3.successful_transactions_count).to eq 0
      end
    end

    describe '#full_name' do
      it 'returns the full name of the customer' do
          @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )

        expect(@customer_1.full_name).to eq "One Customer"
      end
    end
  end
end
