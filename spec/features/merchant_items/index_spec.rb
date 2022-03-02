require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Pabu")
    @merchant2 = Merchant.create!(name: "Loki")
    @item1 = @merchant1.items.create!(name: "Ferret Food", unit_price: 20)
    @item2 = @merchant1.items.create!(name: "Ferret Leash", unit_price: 20)
    @item3 = @merchant2.items.create!(name: "Ferret Shampoo", unit_price: 20)

    @nike = Merchant.create!(name: "Nike")
    @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)
    @jordan_6 = @nike.items.create!(name: "Jordan 6", unit_price: 165)
  end

  describe 'User Story 35' do
    it 'shows every item belonging to merchant' do
      visit merchant_items_path(@merchant1)

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_no_content(@item3.name)
    end
  end
  describe 'User Story 32' do
    describe 'changes status of item between enabled and disabled' do
      it 'has a button to disable status' do
        visit merchant_items_path(@nike)
        expect(current_path).to eq(merchant_items_path(@nike))

        expect(page).to have_button("Disable #{@af_one.name} Item")
        expect(page).to have_button("Disable #{@jordan_6.name} Item")
      end

      it 'clicks that item and only that item is disabled' do
        visit merchant_items_path(@nike)
        expect(current_path).to eq(merchant_items_path(@nike))

        expect(page).to have_button("Disable #{@af_one.name} Item")
        click_on "Disable #{@af_one.name} Item"

        expect(current_path).to eq(merchant_items_path(@nike))
        expect(page).to have_button("Enable #{@af_one.name} Item")
        expect(page).to_not have_button("Disable #{@af_one.name} Item")
        end
      end
    end
  end

  describe 'User Story 31' do
    describe 'has sections for enabled and disabled items and lists those items in each section' do
      before(:each) do
        @nike = Merchant.create!(name: "Nike")
        @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)
        @jordan_6 = @nike.items.create!(name: "Jordan 6", unit_price: 165)
      end
    it 'has a section for disabled and enabled items' do

      visit merchant_items_path(@nike)
      expect(current_path).to eq(merchant_items_path(@nike))

      within "div.enabled_items" do
        expect(page).to have_content("Enabled Items")
        expect(page).to_not have_content("Disabled Items")
      end

      within "div.disabled_items" do
        expect(page).to have_content("Disabled Items")
        expect(page).to_not have_content("Enabled Items")
      end
    end

    it 'Enabled items section only lists enabled items' do
      visit merchant_items_path(@nike)
      expect(current_path).to eq(merchant_items_path(@nike))

      within "div.enabled_items" do
        expect(page).to have_content("Enabled Items")
        expect(page).to have_content(@af_one.name)
        expect(page).to have_content(@jordan_6.name)
      end

      within "div.disabled_items" do
        expect(page).to have_content("Disabled Items")
        expect(page).to_not have_content(@af_one.name)
        expect(page).to_not have_content(@jordan_6.name)
      end
    end

    it 'Disabled items section only lists disabled items' do
      visit merchant_items_path(@nike)
      expect(current_path).to eq(merchant_items_path(@nike))

      click_on "Disable #{@jordan_6.name} Item"

      within "div.enabled_items" do
        expect(page).to have_content(@af_one.name)
        expect(page).to_not have_content(@jordan_6.name)
      end

      within "div.disabled_items" do
        expect(page).to_not have_content(@af_one.name)
        expect(page).to have_content(@jordan_6.name)
      end
    end
  end

  describe 'creating an item' do
    before(:each) do
      @nike = Merchant.create!(name: "Nike")
    end

    it 'visitor sees a link to create a new item' do
      visit merchant_items_path(@nike)

      click_link("Create New Item")
      expect(current_path).to eq(new_merchant_item_path(@nike))
    end
  end
  describe 'User Story 29' do
    before(:each) do
      @merchant = Merchant.create!(name: "Pabu")

      @item1 = Item.create(name: 'Ferret Leash', description: 'Long', unit_price: 15, merchant_id: @merchant.id)
      @item2 = Item.create(name: 'Ferret Food', description: 'Tastey', unit_price: 20, merchant_id: @merchant.id)
      @item2 = Item.create(name: 'Ferret Shampoo', description: 'Soapy', unit_price: 10, merchant_id: @merchant.id)

      @customer1 = Customer.create!(first_name: 'Thor',last_name:'Customer' )
      @customer2 = Customer.create!(first_name: 'Loki',last_name:'Customer' )
      @customer2 = Customer.create!(first_name: 'Apollo',last_name:'Customer' )

      @invoice1 = Invoice.create(customer_id: @customer1.id, status: 1)
      @invoice2 = Invoice.create(customer_id: @customer2.id, status: 1)
      @invoice3 = Invoice.create(customer_id: @customer3.id, status: 1)

      @invoice_item1 = InvoiceItem.create(quantity: 10, unit_price: 15, invoice_id: @invoice1.id, item_id: @shoe_1.id, status: 2)
      @invoice_item2 = InvoiceItem.create(quantity: 4, unit_price: 20, invoice_id: @invoice2.id, item_id: @shoe_1.id, status: 1)
      @invoice_item3 = InvoiceItem.create(quantity: 2, unit_price: 10, invoice_id: @invoice3.id, item_id: @shoe_1.id, status: 1)

      visit merchant_items_path(@merchant)
    end
    it 'shows top 5 most popular items' do
      expect()
    end
end
