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

RSpec.describe 'User story 33' do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Pabu")
    @merchant2 = Merchant.create!(name: "Loki")
    @item1 = @merchant1.items.create!(name: "Ferret Food", description: "Yummy", unit_price: 20)
    @item2 = @merchant1.items.create!(name: "Ferret Leash", description: "Long", unit_price: 20)
    @item3 = @merchant2.items.create!(name: "Ferret Shampoo", description: "Tastey", unit_price: 20)
  end

  it 'has link to take to edit page' do
    visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

    click_link "Update #{@item1.name} info"

    expect(page).to have_current_path("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
  end
  it 'edit page updates item info' do
    visit "/merchants/#{@merchant1.id}/items/#{@item1.id}/edit"

    fill_in 'Name', with: 'Cat food'
    fill_in 'Description', with: 'Good stuff'
    fill_in 'Unit price', with: 15
    click_button "Save"

    expect(page).to have_current_path(merchant_item_path(@merchant1, @item1))

    expect(page).to have_content("Cat food")
    expect(page).to have_content("Good stuff")
    expect(page).to have_content(15)

    expect(page).to have_no_content(@item1.name)
    expect(page).to have_no_content(@item1.description)
    expect(page).to have_no_content(@item1.unit_price)
  end
end
