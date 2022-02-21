require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice}
  end

  describe 'validations' do
    it { should define_enum_for(:result).with_values([:failed, :success]) }
    it { should have_many(:customers).through(:invoice)}
    it { should have_many(:invoice_items).through(:invoice)}
    it { should have_many(:items).through(:invoice_items)}
    it { should have_many(:merchants).through(:items)}
  end
end
