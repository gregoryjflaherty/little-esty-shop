require 'rails_helper'

describe 'merchant item create' do
  before(:each) do
    @nike = Merchant.create!(name: "Nike")
  end 

  it 'shows a form to create a new item and adds it to index page' do
    visit new_merchant_item_path(@nike.id)

    fill_in('name', with: 'dog sweater')
    fill_in('description', with: 'your dog deserves Nike')
    fill_in('unit_price', with: '10.00')
    click_button 'Submit'
    expect(current_path).to eq(merchant_items_path(@nike))
    expect(page).to have_content('dog sweater')
  end
end