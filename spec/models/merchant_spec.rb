require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:customers).through(:invoices)}
  end


  before(:each) do
    @nike = Merchant.create(name: "Nike")
    @adidas = Merchant.create(name: "Adidas")
    @vans = Merchant.create(name: "Vans")
    @converse = Merchant.create(name: "Converse")
    @polo = Merchant.create(name: "Polo")
    @timberland = Merchant.create(name: "Timberland")

    @shoe_1 = Item.create(name: 'shoe_1', merchant_id: @nike.id, unit_price: 100)
    @shoe_2 = Item.create(name: 'shoe_2', merchant_id: @nike.id, unit_price: 100)
    @shoe_3 = Item.create(name: 'shoe_3', merchant_id: @nike.id, unit_price: 100)
    @shoe_4 = Item.create(name: 'shoe_4', merchant_id: @nike.id, unit_price: 100)
    @shoe_5 = Item.create(name: 'shoe_5', merchant_id: @nike.id, unit_price: 100)
    @shoe_6 = Item.create(name: 'shoe_6', merchant_id: @nike.id, unit_price: 100)
    @shoe_7 = Item.create(name: 'shoe_7', merchant_id: @nike.id, enabled: false)
    @shoe_8 = Item.create(name: 'shoe_8', merchant_id: @nike.id, enabled: false)
    @shoe_9 = Item.create(name: 'shoe_9', merchant_id: @nike.id, enabled: false)

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

    @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_1.id, status: 2, unit_price: 100, quantity: 1)
    @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_2.id, status: 1, unit_price: 100, quantity: 1)
    @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @shoe_3.id, status: 1, unit_price: 100, quantity: 1)
    @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @shoe_4.id, status: 1, unit_price: 100, quantity: 1)
    @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @shoe_5.id, status: 1, unit_price: 100, quantity: 1)
    @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @shoe_6.id, status: 1, unit_price: 100, quantity: 1)

    @transaction_1 = Transaction.create(invoice_id: @invoice_item_1.invoice.id, result: 0)
    @transaction_2 = Transaction.create(invoice_id: @invoice_item_2.invoice.id, result: 1)
    @transaction_3 = Transaction.create(invoice_id: @invoice_item_3.invoice.id, result: 1)
    @transaction_4 = Transaction.create(invoice_id: @invoice_item_4.invoice.id, result: 1)
    @transaction_5 = Transaction.create(invoice_id: @invoice_item_5.invoice.id, result: 1)
    @transaction_6 = Transaction.create(invoice_id: @invoice_item_6.invoice.id, result: 1)
  end

  describe '.instance methods' do
    describe '.top_five_customers' do
      it 'returns top five cutomers with most most transactions' do
        expected = [@customer_2, @customer_3, @customer_4, @customer_5, @customer_6]
        results = @nike.top_five_customers.map do |customer|
          customer
        end

        expect(expected).to eq(results)
      end
    end

    it '.items_not_shipped returns unshipped items ordered by invoice date' do
      expect(@nike.items_not_shipped).to eq([@shoe_2, @shoe_3, @shoe_4, @shoe_5, @shoe_6])
    end
  end

  describe '.enabled_disabled_items' do
    it 'provides all items that are enabled' do
      results = [@shoe_1, @shoe_2, @shoe_3, @shoe_4, @shoe_5, @shoe_6]
      expect(@nike.enabled_disabled_items(true)).to eq(results)
    end

    it '.provides all items that are disabled' do
      results = [@shoe_7, @shoe_8, @shoe_9]
      expect(@nike.enabled_disabled_items(false)).to eq(results)
    end
  end

  describe '#class methods' do
    describe '#top_five_by_revenue' do
      before(:each) do
        @nike = Merchant.create!(name: "Nike")
        @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)

        @adidas = Merchant.create!(name: "Adidas")
        @a_six = @adidas.items.create!(name: "A6", unit_price: 165)

        @timberland = Merchant.create!(name: "Timberland")
        @boot = @timberland.items.create!(name: "Greys", unit_price: 300)

        @converse = Merchant.create!(name: "Converse")
        @high_tops = @converse.items.create!(name: "High-tops", unit_price: 100)

        @vans = Merchant.create!(name: "Timberland")
        @originals = @vans.items.create!(name: "OG's", unit_price: 50)

        @polo = Merchant.create!(name: "Polo")
        @lows = @polo.items.create!(name: "Lows", unit_price: 75)

        @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )

        @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
        @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 1)
        @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 1)
        @invoice_4 = Invoice.create(customer_id: @customer_1.id, status: 1)
        @invoice_5 = Invoice.create(customer_id: @customer_1.id, status: 1)
        @invoice_6 = Invoice.create(customer_id: @customer_1.id, status: 1)

        @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @af_one.id, status: 2, unit_price: 125, quantity: 1)
        @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @boot.id, status: 1, unit_price: 300, quantity: 1)
        @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @lows.id, status: 1, unit_price: 75, quantity: 1)
        @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @originals.id, status: 1, unit_price: 50, quantity: 1)
        @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @a_six.id, status: 1, unit_price: 165, quantity: 1)
        @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @high_tops.id, status: 1, unit_price: 100, quantity: 1)

        @transaction_1 = Transaction.create(invoice_id: @invoice_item_1.invoice.id, result: 0)
        @transaction_2 = Transaction.create(invoice_id: @invoice_item_2.invoice.id, result: 1)
        @transaction_3 = Transaction.create(invoice_id: @invoice_item_3.invoice.id, result: 1)
        @transaction_4 = Transaction.create(invoice_id: @invoice_item_4.invoice.id, result: 1)
        @transaction_5 = Transaction.create(invoice_id: @invoice_item_5.invoice.id, result: 1)
        @transaction_6 = Transaction.create(invoice_id: @invoice_item_6.invoice.id, result: 1)
      end

      it 'gets top 5 merchants by most revenue' do
        results = Merchant.top_five_by_revenue
        expect(results[0].name).to eq(@nike.name)
        expect(results[1].name).to eq(@timberland.name)
        expect(results[2].name).to eq(@adidas.name)
        expect(results[3].name).to eq(@converse.name)
        expect(results[4].name).to eq(@polo.name)
      end
    end
  end
end
