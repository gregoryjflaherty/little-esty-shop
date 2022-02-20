require 'rails_helper'

RSpec.describe 'User story 38' do
  before(:each) do
    @nike = Merchant.create!(name: "Nike")
    visit "/merchants/#{@nike.id}/dashboard"
  end

  xit 'shows top 5 customers ' do
    
  end
end
