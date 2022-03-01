require 'rails_helper'

RSpec.describe 'merchant invoice show page' do

  before(:each) do
    @nike = Merchant.create!(name: "Nike")

    @shoe_1 = Item.create(name: 'running shoe', description: 'shoe for running', unit_price: 100, merchant_id: @nike.id)
    @shoe_2 = Item.create(name: 'trail running shoe', description: 'shoe for trail running', unit_price: 200, merchant_id: @nike.id)
    @shoe_3 = Item.create(name: 'hiking shoe', description: 'shoe for hiking', unit_price: 150, merchant_id: @nike.id)

    @customer_1 = Customer.create!(first_name: 'Bob',last_name:'Vance' )

    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1)

    @invoice_item_1 = InvoiceItem.create(quantity: 2, unit_price: 100, invoice_id: @invoice_1.id, item_id: @shoe_1.id, status: 1)
    @invoice_item_2 = InvoiceItem.create(quantity: 2, unit_price: 100, invoice_id: @invoice_1.id, item_id: @shoe_2.id, status: 0)
    @invoice_item_3 = InvoiceItem.create(quantity: 2, unit_price: 100, invoice_id: @invoice_1.id, item_id: @shoe_3.id, status: 2)

    visit merchant_invoice_path(@nike.id, @invoice_1.id)
  end 

  it 'shows info related to that invoice' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
  end

  it 'shows invoice #created_at date formatted in DAY, MM DD, YYYY' do
    expect(page).to have_content(@invoice_1.creation_date_formatted)
  end

  describe 'item status update field' do
    it 'merchant sees item status select field and submit button next to each item' do
      within "#item#{@shoe_2.id}" do
        expect(page).to have_field('Status', with: 'packaged')
        expect(page).to have_button("Update Item Status")
      end

      within "#item#{@shoe_1.id}" do
        expect(page).to have_field('Status', with: 'pending')
        expect(page).to have_button("Update Item Status")
      end

      within "#item#{@shoe_3.id}" do
        expect(page).to have_field('Status', with: 'shipped')
        expect(page).to have_button("Update Item Status")
      end
    end

    it 'the item select field is populated by item status and changes when updated' do
      within "#item#{@shoe_2.id}" do
        expect(page).to have_field('Status', with: 'packaged')
        expect(page).to have_button("Update Item Status")

        select "Pending", from: "Status"
        click_button("Update Item Status")
      end

      expect(current_path).to eq(merchant_invoice_path(@nike.id, @invoice_1.id))

      within "#item#{@shoe_2.id}" do
        expect(page).to have_field('Status', with: 'pending')
        expect(page).to have_no_field('Status', with: 'packaged')

        select "Shipped", from: "Status"
        click_button("Update Item Status")
      end

      expect(current_path).to eq(merchant_invoice_path(@nike.id, @invoice_1.id))

      within "#item#{@shoe_2.id}" do
        expect(page).to have_field('Status', with: 'shipped')
        expect(page).to have_no_field('Status', with: 'pending')

        select "Packaged", from: "Status"
        click_button("Update Item Status")
      end
        expect(current_path).to eq(merchant_invoice_path(@nike.id, @invoice_1.id))

      within "#item#{@shoe_2.id}" do
        expect(page).to have_field('Status', with: 'packaged')
        expect(page).to have_no_field('Status', with: 'shipped')
        save_and_open_page
      end
    end
  end
end