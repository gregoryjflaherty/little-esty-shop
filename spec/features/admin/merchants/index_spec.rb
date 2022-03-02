require 'rails_helper'

RSpec.describe 'Admin/Merchants Index' do
  describe '#us17' do
    it 'It shows the name of all the merchants' do
      @merchant1 = Merchant.create!(name: "Pabu")
      @merchant2 = Merchant.create!(name: "Loki")
      @merchant3 = Merchant.create!(name: "Nike")
      @merchant4 = Merchant.create!(name: "Adidas")


      visit admin_merchants_path

      within "div.disabled_merchants" do
        expect(page).to have_content('Pabu')
        expect(page).to have_content('Loki')
        expect(page).to have_content('Nike')
        expect(page).to have_content('Adidas')
      end
    end
  end
  describe 'US-14 changes status of item between enabled and disabled' do
    it 'has a button to disable status' do
      @merchant1 = Merchant.create!(name: "Pabu")
      @merchant2 = Merchant.create!(name: "Loki")
      @merchant3 = Merchant.create!(name: "Nike")
      @merchant4 = Merchant.create!(name: "Adidas")

      visit admin_merchants_path
      expect(current_path).to eq(admin_merchants_path)

      within "div.disabled_merchants" do
        expect(page).to have_button("Enable #{@merchant1.name}")
        expect(page).to have_button("Enable #{@merchant2.name}")
      end
    end

    it 'clicks that merchant and only that merchant is enabled' do
      @merchant1 = Merchant.create!(name: "Pabu")
      @merchant2 = Merchant.create!(name: "Loki")
      @merchant3 = Merchant.create!(name: "Nike")
      @merchant4 = Merchant.create!(name: "Adidas")

      visit admin_merchants_path
      expect(current_path).to eq(admin_merchants_path)

      within "div.disabled_merchants" do
        expect(page).to have_button("Enable #{@merchant1.name}")
        expect(page).to have_button("Enable #{@merchant2.name}")
      end

      click_on "Enable #{@merchant1.name}"

      expect(current_path).to eq(admin_merchants_path)

      within "div.enabled_merchants" do
        expect(page).to have_button("Disable #{@merchant1.name}")
      end

      within "div.disabled_merchants" do
        expect(page).to have_button("Enable #{@merchant2.name}")
      end
    end
  end
end
