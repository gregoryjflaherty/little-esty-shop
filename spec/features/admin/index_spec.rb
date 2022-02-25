require 'rails_helper'

RSpec.describe 'Admin Index' do
  describe '#us22' do
    it 'It shows Admin Header' do
      visit '/admin/'

      expect(page).to have_content('Admin Dashboard')
    end
  end
end
