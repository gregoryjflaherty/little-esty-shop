require 'rails_helper'

RSpec.describe 'admin_invoices show page' do
  before(:each) do
    @nike = Merchant.create!(name: "Nike")
    @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)

    @customer_1 = Customer.create!(first_name:'Fake',last_name:'Customer' )

    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: '2022-01-01')
  end

  describe 'User Story 8' do
    it 'goes to invoice show page which include id, status, created_at, and full name' do
      visit admin_invoice_path(@invoice_1)
      expect(current_path).to eq(admin_invoice_path(@invoice_1))

      expect(page).to have_content("Invoice: #{@invoice_1.id}")
      expect(page).to have_content("Invoice status: #{@invoice_1.status}")
      expect(page).to have_content("Created at: #{@invoice_1.creation_date_formatted}")
      expect(page).to have_content("For: #{@customer_1.full_name}")
    end
  end

  describe 'invoice status change' do
    it 'visitor can select new status and update it' do
      visit admin_invoice_path(@invoice_1)
      expect(page).to have_field('Status', with: 'completed')
      expect(page).to have_button('Update Invoice Status')

      select 'Cancelled', from: 'Status'
      click_button('Update Invoice Status')

      expect(current_path).to eq(admin_invoice_path(@invoice_1.id))
      expect(page).to have_field('Status', with: 'cancelled')

      select 'In Progress', from: 'Status'
      click_button('Update Invoice Status')

      expect(current_path).to eq(admin_invoice_path(@invoice_1.id))
      expect(page).to have_field('Status', with: 'in progress')

      select 'Completed', from: 'Status'
      click_button('Update Invoice Status')

      expect(current_path).to eq(admin_invoice_path(@invoice_1.id))
      expect(page).to have_field('Status', with: 'completed')
    end
  end
end
