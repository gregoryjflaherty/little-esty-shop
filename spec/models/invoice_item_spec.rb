require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it {should belong_to(:item)}
    it {should belong_to(:invoice)}
    it {should have_many(:merchants).through(:item)}
    it {should have_many(:customers).through(:invoice)}
    it {should have_many(:transactions).through(:invoice)}
  end

  describe 'validations' do
    it { should define_enum_for(:status).with_values([:packaged, :pending, :shipped]) }
  end

  describe '#invoice_creation_date' do

    before(:each) do
      @nike = Merchant.create(name: "Nike")

      @shoe_1 = Item.create(name: 'shoe_1', description: 'shoe #1', unit_price: 200, merchant_id: @nike.id)

      @customer_1 = Customer.create!(first_name: 'Bob',last_name:'Vance' )

      @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
  
      @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_1.id, quantity: 1, unit_price: 200, status: 2)
    end 
    
    it 'converts the invoice item invoice creation date to Day of Week, MM DD,YYYY' do
      expect(@invoice_item_1.invoice_creation_date).to eq('Tuesday, March 01, 2022')
    end
  end
end
