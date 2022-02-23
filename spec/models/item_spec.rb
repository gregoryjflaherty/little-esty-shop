require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant}
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
  end

  describe '.instance methods' do
    describe '.change_enabled_status' do
      it 'its enabled status it true by default' do
        @nike = Merchant.create!(name: "Nike")
        @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)

        expect(@af_one.enabled).to eq(true)
      end

      it 'it changes enabled status' do
        @nike = Merchant.create!(name: "Nike")
        @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)

        @af_one.change_enabled_status
        expect(@af_one.enabled).to eq(false)
      end
    end
  end
end
