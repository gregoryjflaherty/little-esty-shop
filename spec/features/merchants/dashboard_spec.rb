require 'rails_helper'

RSpec.describe 'User story 40' do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Pabu")
    visit "/merchants/#{@merchant1.id}/dashboard"
  end
  
  it 'shows every merchant' do
    expect(page).to have_content(@merchant1.name)
  end

  describe 'User Story 39' do
    it 'shows a link to merchant items and merchant invoices' do

      expect(page).to have_content("Invoices")
      click_link "Invoices"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
    end

    it 'shows a link to merchant items and merchant items' do

      expect(page).to have_content("Items")
      click_link "Items"
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    end
  end
end
