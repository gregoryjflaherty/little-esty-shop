require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should have_many :items}
    it { should have_many :invoices}
  end 

  describe 'validations' do
    it { should define_enum_for(:status).with([:packaged, :pending, :shipped]) }
  end
end
