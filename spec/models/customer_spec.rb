require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it {should have_many(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:invoice_items).through(:invoices)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
  end

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

  describe '.instance methods' do

    describe '.successful_transactions' do
      it 'returns the count of successful transactions' do

        expect(@customer_1.successful_transactions_count).to eq 5
        expect(@customer_2.successful_transactions_count).to eq 4
        expect(@customer_3.successful_transactions_count).to eq 3
      end
    end

    describe '.full_name' do
      it 'returns the full name of the customer' do
          @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )

        expect(@customer_1.full_name).to eq "One Customer"
      end
    end
  end
  describe '#class methods' do
    it '#top_five_customers' do
      @customers = Customer.all
      expect(@customers.top_five_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
    end
  end
end
