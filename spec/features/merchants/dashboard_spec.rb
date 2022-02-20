require 'rails_helper'

RSpec.describe 'User story 40' do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Pabu")
    visit "/merchants/#{@merchant1.id}/dashboard"
  end
  
  it 'shows every merchant' do
    expect(page).to have_content(@merchant1.name)
  end
end
