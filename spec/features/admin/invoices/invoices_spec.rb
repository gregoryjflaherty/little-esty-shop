require 'rails_helper' 

RSpec.describe 'admin invoices index' do
  before(:each) do
    @nike = Merchant.create!(name: "Nike")
    
    @af_one = @nike.items.create!(name: "Air Force One", unit_price: 120)

    @customer_1 = Customer.create!(first_name:'Michael',last_name:'Scott' )

    @invoice_1 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: '2022-01-01')
    @invoice_2 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: '2022-01-01')
    @invoice_3 = Invoice.create(customer_id: @customer_1.id, status: 1, created_at: '2022-01-01')
    
    visit admin_invoices_path
  end

  it 'shows list of all invoice ids' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to have_content(@invoice_2.id)
  end

  it 'links each id to admin invoice show page' do
    click_link("#{@invoice_1.id}")
    expect(current_path).to eq(admin_invoice_path(@invoice_1.id))
  end
end