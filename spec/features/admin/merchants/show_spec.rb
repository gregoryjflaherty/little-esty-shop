require 'rails_helper'

RSpec.describe 'Admin/Merchants Show' do
  describe '#us16' do
    it 'It shows the name of the individual merchant' do
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

      click_on "Pabu"

      expect(current_path).to eq(admin_merchant_path(@merchant1))
    end
  end
end
