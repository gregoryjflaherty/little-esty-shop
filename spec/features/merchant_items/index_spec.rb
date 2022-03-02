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
      @nike = Merchant.create(name: "Nike")
      @adidas = Merchant.create(name: "Adidas")
      @vans = Merchant.create(name: "Vans")
      @converse = Merchant.create(name: "Converse")
      @polo = Merchant.create(name: "Polo")
      @timberland = Merchant.create(name: "Timberland")

      @shoe_1 = Item.create(name: 'shoe1', merchant_id: @nike.id, unit_price: 150)
      @shoe_2 = Item.create(name: 'shoe2', merchant_id: @nike.id, unit_price: 100)
      @shoe_3 = Item.create(name: 'shoe3', merchant_id: @nike.id, unit_price: 200)
      @shoe_4 = Item.create(name: 'shoe4', merchant_id: @nike.id, unit_price: 50)
      @shoe_5 = Item.create(name: 'shoe5', merchant_id: @nike.id, unit_price: 100)
      @shoe_6 = Item.create(name: 'shoe6', merchant_id: @nike.id, unit_price: 300)
      @shoe_7 = Item.create(name: 'shoe7', merchant_id: @nike.id, enabled: false)
      @shoe_8 = Item.create(name: 'shoe8', merchant_id: @nike.id, enabled: false)
      @shoe_9 = Item.create(name: 'shoe9', merchant_id: @nike.id, enabled: false)

      @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )
      @customer_2 = Customer.create!(first_name: 'Two',last_name:'Customer' )
      @customer_3 = Customer.create!(first_name: 'Three' ,last_name:'Customer' )
      @customer_4 = Customer.create!(first_name: 'Four',last_name:'Customer' )
      @customer_5 = Customer.create!(first_name: 'Five',last_name:'Customer' )
      @customer_6 = Customer.create!(first_name: 'Six',last_name:'Customer' )

      @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_2 = Invoice.create(customer_id: @customer_2.id, status: 1)
      @invoice_3 = Invoice.create(customer_id: @customer_3.id, status: 1)
      @invoice_4 = Invoice.create(customer_id: @customer_4.id, status: 1)
      @invoice_5 = Invoice.create(customer_id: @customer_5.id, status: 1)
      @invoice_6 = Invoice.create(customer_id: @customer_6.id, status: 1)

      @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @shoe_1.id, status: 2, unit_price: 150, quantity: 1)
      @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @shoe_2.id, status: 1, unit_price: 100, quantity: 4)
      @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @shoe_3.id, status: 1, unit_price: 200, quantity: 1)
      @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @shoe_4.id, status: 1, unit_price: 50, quantity: 1)
      @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @shoe_5.id, status: 1, unit_price: 100, quantity: 2)
      @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @shoe_6.id, status: 1, unit_price: 300, quantity: 1)

      @transaction_1 = Transaction.create(invoice_id: @invoice_item_1.invoice.id, result: 1)
      @transaction_2 = Transaction.create(invoice_id: @invoice_item_2.invoice.id, result: 1)
      @transaction_3 = Transaction.create(invoice_id: @invoice_item_3.invoice.id, result: 1)
      @transaction_4 = Transaction.create(invoice_id: @invoice_item_4.invoice.id, result: 1)
      @transaction_5 = Transaction.create(invoice_id: @invoice_item_5.invoice.id, result: 1)
      @transaction_6 = Transaction.create(invoice_id: @invoice_item_6.invoice.id, result: 1)

      visit merchant_items_path(@nike)
    end
    it 'shows top 5 most popular items' do
      within "div.top_five_items" do
        expect(page).to have_content(@shoe_1.name)
        expect(page).to have_content(@shoe_2.name)
        expect(page).to have_content(@shoe_3.name)
        expect(page).to have_content(@shoe_6.name)
        expect(page).to have_content(@shoe_5.name)
        expect(page).to have_no_content(@shoe_4.name)
      end
    end
  end
end
