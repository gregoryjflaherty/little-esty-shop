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

  before(:each) do
    @nike = Merchant.create(name: "Nike")
    @vans = Merchant.create(name: "Vans")

    @shoe_1 = Item.create(name: 'shoe_1', merchant_id: @nike.id)
    @shoe_2 = Item.create(name: 'shoe_2', merchant_id: @vans.id)

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
    @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @shoe_2.id, status: 1)
    @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @shoe_1.id, status: 1)
    @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @shoe_1.id, status: 0)
    @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @shoe_1.id, status: 0)


    @transaction_1 = Transaction.create(invoice_id: @invoice_item_1.invoice.id, result: 0)
    @transaction_2 = Transaction.create(invoice_id: @invoice_item_2.invoice.id, result: 1)
    @transaction_3 = Transaction.create(invoice_id: @invoice_item_3.invoice.id, result: 1)
    @transaction_4 = Transaction.create(invoice_id: @invoice_item_4.invoice.id, result: 1)
    @transaction_5 = Transaction.create(invoice_id: @invoice_item_5.invoice.id, result: 1)
    @transaction_6 = Transaction.create(invoice_id: @invoice_item_6.invoice.id, result: 1)
  end

  describe 'instance methods' do

  end

  describe 'class methods' do
    it '#invoice_created_sorted' do
      expect(InvoiceItem.invoice_created_sorted(@nike)).to eq([@invoice_item_5, @invoice_item_6])
      # "#{test.created_at.strftime("%A")}, #{test.created_at.to_s(:long)}"
    end
  end
end
