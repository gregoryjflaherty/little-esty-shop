require 'rails_helper'

RSpec.describe 'User story 34' do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Pabu")
    @merchant2 = Merchant.create!(name: "Loki")
    @item1 = @merchant1.items.create!(name: "Ferret Food", unit_price: 20)
    @item2 = @merchant1.items.create!(name: "Ferret Leash", unit_price: 20)
    @item3 = @merchant2.items.create!(name: "Ferret Shampoo", unit_price: 20)
  end

  it 'item name on index page goes to item show page' do

    visit merchant_items_path(@merchant1)

    click_link "#{@item1.name}"

    expect(page).to have_current_path(merchant_item_path(@merchant1, @item1))
  end

  it 'shows every items attributes' do
    visit merchant_item_path(@merchant1, @item1)

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.description)
    expect(page).to have_content(@item1.unit_price)
  end
end
