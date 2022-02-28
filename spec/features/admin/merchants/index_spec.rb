require 'rails_helper'

RSpec.describe 'Admin?Merchants Index' do
  describe '#us17' do
    it 'It shows the name of all the merchants' do
      @merchant1 = Merchant.create!(name: "Pabu")
      @merchant2 = Merchant.create!(name: "Loki")
      @merchant3 = Merchant.create!(name: "Nike")
      @merchant4 = Merchant.create!(name: "Adidas")


      visit admin_merchants_path

      within "div.merchants" do
        expect(page).to have_content('Pabu')
        expect(page).to have_content('Loki')
        expect(page).to have_content('Nike')
        expect(page).to have_content('Adidas')
      end
    end
  end
end
