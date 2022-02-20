require 'rails_helper'

RSpec.describe 'User story 34' do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Pabu")
    @merchant2 = Merchant.create!(name: "Loki")
    @item1 = @merchant1.items.create!(name: "Ferret Food", unit_price: 20)
    @item2 = @merchant1.items.create!(name: "Ferret Leash", unit_price: 20)
    @item3 = @merchant2.items.create!(name: "Ferret Shampoo", unit_price: 20)
    visit "/merchants/#{@merchant1.id}/items"

  end
  it 'shows every items attributes' do
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.description)
    expect(page).to have_no_content(@item1.unit_price)
  end
end
