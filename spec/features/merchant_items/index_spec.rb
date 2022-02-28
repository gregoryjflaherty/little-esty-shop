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

#   As an admin,
# When I visit the admin merchants index
# Then I see the names of the top 5 merchants by total revenue generated
# And I see that each merchant name links to the admin merchant show page for that merchant
# And I see the total revenue generated next to each merchant name
  describe "User Story 11" do
    before(:each) do
      @nike = Merchant.create!(name: "Nike")
      @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)

      @adidas = Merchant.create!(name: "Adidas")
      @a_six = @adidas.items.create!(name: "A6", unit_price: 165)

      @timberland = Merchant.create!(name: "Timberland")
      @boot = @timberland.items.create!(name: "Greys", unit_price: 300)

      @converse = Merchant.create!(name: "Converse")
      @high_tops = @converse.items.create!(name: "High-tops", unit_price: 100)

      @vans = Merchant.create!(name: "Timberland")
      @originals = @vans.items.create!(name: "OG's", unit_price: 50)

      @polo = Merchant.create!(name: "Polo")
      @lows = @polo.items.create!(name: "Lows", unit_price: 75)

      @customer_1 = Customer.create!(first_name: 'One',last_name:'Customer' )

      @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_4 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_5 = Invoice.create(customer_id: @customer_1.id, status: 1)
      @invoice_6 = Invoice.create(customer_id: @customer_1.id, status: 1)

      @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @af_one.id, status: 2, unit_price: 125, quantity: 1)
      @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @boot.id, status: 1, unit_price: 300, quantity: 1)
      @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @lows.id, status: 1, unit_price: 75, quantity: 1)
      @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @originals.id, status: 1, unit_price: 50, quantity: 1)
      @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @a_six.id, status: 1, unit_price: 165, quantity: 1)
      @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @high_tops.id, status: 1, unit_price: 100, quantity: 1)

      @transaction_1 = Transaction.create(invoice_id: @invoice_item_1.invoice.id, result: 0)
      @transaction_2 = Transaction.create(invoice_id: @invoice_item_2.invoice.id, result: 1)
      @transaction_3 = Transaction.create(invoice_id: @invoice_item_3.invoice.id, result: 1)
      @transaction_4 = Transaction.create(invoice_id: @invoice_item_4.invoice.id, result: 1)
      @transaction_5 = Transaction.create(invoice_id: @invoice_item_5.invoice.id, result: 1)
      @transaction_6 = Transaction.create(invoice_id: @invoice_item_6.invoice.id, result: 1)
    end
    describe 'shows top 5 merchants by revenue, each name links to merchant show page - showing total revenue' do
      it 'shows top 5 merchants' do
        visit admin_merchants_path
        expect(current_path).to eq(admin_merchants_path)

        expect(page).to have_content("Top Merchants")
        within "div.top_five_customers" do
          expect(@timberland.name).to appear_before(@adidas.name)
          expect(@adidas.name).to appear_before(@nike.name)
          expect(@nike.name).to appear_before(@converse.name)
          expect(@converse.name).to appear_before(@polo.name)
        end
      end

      xit 'links to merchants show page' do

      end

      xit 'merchant show page shows total revenue' do

      end
    end
  end
end
