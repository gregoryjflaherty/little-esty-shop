require 'rails_helper'

RSpec.describe "Admin Merchant New Page" do

  it "has a form for new Admin Merchant, and redirects to admin merchant index with new merchant listed. Default status is Disabled" do
    visit new_admin_merchant_path

    within('#create_admin_merchant') do
      fill_in "Name:", with: "Gunnar"
      click_button "Submit"
      expect(current_path).to eq(admin_merchants_path)
    end
    within "div.merchants" do
      expect(page).to have_content("Gunnar")
    end
  end
end
