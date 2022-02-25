require 'rails_helper'

RSpec.describe 'Admin Index' do
  describe '#us22' do
    it 'It shows Admin Header' do
      visit '/admin/'

      expect(page).to have_content('Admin Dashboard')
    end
  end

  describe 'US 21' do
    it 'has links to merchant index' do
      visit '/admin/'
      expect(page).to have_link("All Merchants")

      click_on "All Merchants"
      expect(current_path).to eq('/admin/merchants')
    end

    it 'has links to invoices index' do
      visit '/admin/'
      expect(page).to have_link("All Invoices")

      click_on "All Invoices"
      expect(current_path).to eq('/admin/invoices')
    end
  end
end
