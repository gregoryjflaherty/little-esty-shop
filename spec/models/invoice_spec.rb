require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer}
    it { should have_many :transactions}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values([:cancelled, :completed, "in progress"]) }
  end

    before(:each) do
      @nike = Merchant.create(name: "Nike")
      @adidas = Merchant.create!(name: "Adidas")

      @shoe_1 = Item.create(name: 'shoe_1', description: 'shoe #1', unit_price: 200, merchant_id: @nike.id)
      @shoe_2 = Item.create(name: 'shoe_2', description: 'shoe #2', unit_price: 200, merchant_id: @nike.id)
      @shoe_3 = Item.create(name: 'shoe_3', description: 'shoe #3', unit_price: 200, merchant_id: @nike.id)
      @shoe_4 = Item.create(name: 'shoe_4', description: 'shoe #4', unit_price: 200, merchant_id: @nike.id)
      @shoe_5 = Item.create(name: 'shoe_5', description: 'shoe #5', unit_price: 200, merchant_id: @nike.id)
      @shoe_6 = Item.create(name: 'shoe_6', description: 'shoe #6', unit_price: 200, merchant_id: @nike.id)
      @shoe_7 = Item.create(name: 'running shoes', description: 'shoe for running', unit_price: 100, merchant_id: @adidas.id)
      @shoe_8 = Item.create(name: 'trail running shoes', description: 'shoe for trail running', unit_price: 100, merchant_id: @adidas.id)

      @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )
      @customer_2 = Customer.create!(first_name: 'Two',last_name:'Customer' )

      @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_4 = Invoice.create(customer_id: @customer_2.id, status: 1)
      @invoice_5 = Invoice.create(customer_id: @customer_2.id, status: 1)
      @invoice_6 = Invoice.create(customer_id: @customer_2.id, status: 1, created_at: '1989-04-02')

      @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_1.id, quantity: 1, unit_price: 200, status: 2)
      @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_2.id, quantity: 1, unit_price: 200, status: 2)
      @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_3.id, quantity: 1, unit_price: 200, status: 2)
      @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_4.id, quantity: 1, unit_price: 200, status: 1)
      @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_5.id, quantity: 1, unit_price: 200, status: 1)
      @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_6.id, quantity: 1, unit_price: 200, status: 1)
      @invoice_item_7 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @shoe_7.id, quantity: 1, unit_price: 100, status: 2)
      @invoice_item_8 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @shoe_8.id, quantity: 1, unit_price: 100, status: 2)
    end

    describe '#class methods' do
      describe '#incomplete_invoices' do
        it 'collects all invoices that have items that have not been shipped' do
          results = [@invoice_2]
          expect(Invoice.incomplete_invoices).to eq(results)
        end
      end

      describe '#oldest_to_newest' do
        it 'orders results by created_at - oldest to newest' do
          results = [@invoice_6, @invoice_1, @invoice_2, @invoice_3, @invoice_4, @invoice_5]
          expect(Invoice.oldest_to_newest).to eq(results)
        end
      end
    end

    describe 'instance methods' do
      describe '#creation_date_formatted' do
        it 'converts the invoice item invoice creation date to DAY, MM DD, YYYY' do
          expect(@invoice_1.creation_date_formatted).to eq('Wednesday, March 02, 2022')
        end
      end


      describe '#items_by_merchant' do
        it 'returns all item objects associated with invoice for a specific merchant id' do
          expect(@invoice_1.items_by_merchant(@nike.id)).to eq([@shoe_1, @shoe_2, @shoe_3])
          expect(@invoice_1.items_by_merchant(@adidas.id)).to_not include([@shoe_7, @shoe_8])
        end
      end

      describe '.total_revenue' do
        it 'total revenue for that invoice' do
          expect(@invoice_1.total_revenue).to eq(600)
        end
      end
    end
end
