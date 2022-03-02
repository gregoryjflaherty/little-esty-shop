require 'rails_helper'

RSpec.describe 'Admin Merchants Index' do
  describe '#us17' do
    it 'It shows the name of all the merchants' do
      @merchant1 = Merchant.create!(name: "Pabu")
      @merchant2 = Merchant.create!(name: "Loki")
      @merchant3 = Merchant.create!(name: "Nike")
      @merchant4 = Merchant.create!(name: "Adidas")


      visit admin_merchants_path

      within "div.merchants" do
        expect(page).to have_content('Pabu')
        expect(page).to have_content('Loki')
        expect(page).to have_content('Nike')
        expect(page).to have_content('Adidas')
      end
    end
  end

  before(:each) do
    @nike = Merchant.create!(name: "Nike", status: 0)
    @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)

    @adidas = Merchant.create!(name: "Adidas", status: 0)
    @a_six = @adidas.items.create!(name: "A6", unit_price: 165)

    @timberland = Merchant.create!(name: "Timberland")
    @boot = @timberland.items.create!(name: "Greys", unit_price: 300)

    @converse = Merchant.create!(name: "Converse")
    @high_tops = @converse.items.create!(name: "High-tops", unit_price: 100)

    @vans = Merchant.create!(name: "Vans")
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

  describe "User Story 11" do
    describe 'shows top 5 merchants by revenue, each name links to merchant show page - showing total revenue' do
      it 'shows top 5 merchants' do
        visit admin_merchants_path
        expect(current_path).to eq(admin_merchants_path)

        expect(page).to have_content("Top Merchants")
        within "div.top_five_merchants" do
          expect(@timberland.name).to appear_before(@adidas.name)
          expect(@adidas.name).to appear_before(@converse.name)
          expect(@converse.name).to appear_before(@polo.name)
          expect(@polo.name).to appear_before(@vans.name)
        end
      end

      it 'shows revenue' do
        visit admin_merchants_path
        expect(current_path).to eq(admin_merchants_path)

        within "div.top_five_merchants" do
          expect(page).to have_content("#{@timberland.name} - Total revenue - 300")
          expect(page).to have_content("#{@adidas.name} - Total revenue - 165")
          expect(page).to have_content("#{@converse.name} - Total revenue - 100")
          expect(page).to have_content("#{@polo.name} - Total revenue - 75")
          expect(page).to have_content("#{@vans.name} - Total revenue - 50")
        end
      end

      it 'links to merchants show page' do
        visit admin_merchants_path
        expect(current_path).to eq(admin_merchants_path)

        within "div.top_five_merchants" do
          click_on "#{@timberland.name}"
        end

        expect(current_path).to eq(admin_merchant_path(@timberland.id))
      end
    end
  end

  describe 'us10' do
    before(:each) do
      @nike = Merchant.create!(name: "Nike")
      @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)

      @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: "2022-01-01")
      @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: "2022-01-01")
      @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: "2022-01-02")
      @invoice_4 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: "2022-01-02")
      @invoice_5 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: "2022-01-04")
      @invoice_6 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: "2022-01-05")

      @invoice_item_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @af_one.id, status: 1, unit_price: 120, quantity: 1)
      @invoice_item_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @af_one.id, status: 1, unit_price: 120, quantity: 1)
      @invoice_item_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @af_one.id, status: 1, unit_price: 120, quantity: 1)
      @invoice_item_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @af_one.id, status: 1, unit_price: 120, quantity: 1)
      @invoice_item_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @af_one.id, status: 1, unit_price: 120, quantity: 1)
      @invoice_item_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @af_one.id, status: 1, unit_price: 120, quantity: 1)

      @transaction_1 = Transaction.create(invoice_id: @invoice_item_1.invoice.id, result: 1)
      @transaction_2 = Transaction.create(invoice_id: @invoice_item_2.invoice.id, result: 1)
      @transaction_3 = Transaction.create(invoice_id: @invoice_item_3.invoice.id, result: 1)
      @transaction_4 = Transaction.create(invoice_id: @invoice_item_4.invoice.id, result: 1)
      @transaction_5 = Transaction.create(invoice_id: @invoice_item_5.invoice.id, result: 1)
      @transaction_6 = Transaction.create(invoice_id: @invoice_item_6.invoice.id, result: 1)
    end

    describe 'in Top 5 merhcant section- it shows the date with the most revenue' do
      it 'shows best selling date for that merchant' do
        visit admin_merchants_path
        expect(current_path).to eq(admin_merchants_path)

        within "div.top_five_merchants" do
          expect(page).to have_content("Top selling date for #{@nike.name} was Saturday, January 01, 2022")
        end
      end
    end
  end 

  describe 'enabled and disabled merchants section' do
    it 'visitor sees button to disable or enable each merchant next to their name' do
      visit admin_merchants_path
      within("#enabled_merchant-#{@nike.id}") do
        expect(page).to have_button("Disable")
      end
        
      within("#enabled_merchant-#{@adidas.id}") do
        expect(page).to have_button("Disable")
      end

      within("#disabled_merchant-#{@converse.id}") do
        expect(page).to have_button("Enable")
      end
    end

      it 'visitor clicks button and is redirected back to the same page, where they see the Merchant status change' do
        visit admin_merchants_path
        within("#enabled_merchant-#{@nike.id}") do
          click_button("Disable")
          expect(current_path).to eq(admin_merchants_path)
        end

        within("#disabled") do
          expect(page).to have_content(@nike.name)
        end

        within("#disabled_merchant-#{@nike.id}") do
          click_button("Enable")
          expect(current_path).to eq(admin_merchants_path)
        end

        within("#enabled") do
          visit admin_merchants_path
          expect(page).to have_content(@nike.name)
        end
      end
    end
  end

