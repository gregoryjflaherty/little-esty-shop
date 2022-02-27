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

    describe '#class methods' do
      describe '#incomplete_invoices' do
        it 'collects all invoices that have items that have not been shipped' do
          results = [@invoice_2]
          expect(Invoice.incomplete_invoices).to eq(results)
        end
      end
    end
end
