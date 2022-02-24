require 'rails_helper'

RSpec.describe 'User story 35' do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Pabu")
    @merchant2 = Merchant.create!(name: "Loki")
    @item1 = @merchant1.items.create!(name: "Ferret Food", unit_price: 20)
    @item2 = @merchant1.items.create!(name: "Ferret Leash", unit_price: 20)
    @item3 = @merchant2.items.create!(name: "Ferret Shampoo", unit_price: 20)

    @nike = Merchant.create!(name: "Nike")
    @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)
    @jordan_6 = @nike.items.create!(name: "Jordan 6", unit_price: 165)


    visit merchant_items_path(@merchant1)

  end
  it 'shows every item belonging to merchant' do
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_no_content(@item3.name)
  end

  describe 'User Story 32' do
    describe 'changes status of item between enabled and disabled' do
      it 'has a button to disable status' do
        visit merchant_items_path(@nike)
        expect(current_path).to eq(merchant_items_path(@nike))

        within "#item#{@af_one.id}" do
          expect(page).to have_button("Disable #{@af_one.name} Item")
        end

        within "#item#{@jordan_6.id}" do
          expect(page).to have_button("Disable #{@jordan_6.name} Item")
        end
      end

      it 'clicks that item and only that item is disabled' do
        visit merchant_items_path(@nike)
        expect(current_path).to eq(merchant_items_path(@nike))

        within "#item#{@af_one.id}" do
          expect(page).to have_button("Disable #{@af_one.name} Item")
          click_on "Disable #{@af_one.name} Item"

          expect(current_path).to eq(merchant_items_path(@nike))
          expect(page).to have_button("Enable #{@af_one.name} Item")
          expect(page).to_not have_button("Disable #{@af_one.name} Item")
        end
      end
    end
  end
end
