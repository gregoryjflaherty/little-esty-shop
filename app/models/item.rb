class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def change_enabled_status(status)
    if status == 'true'
      update!(enabled: false)
    else
      update!(enabled: true)
    end
  end

  def date_with_most_sales
    invoices
    .joins(:invoice_items)
    .select("invoices.created_at, invoice_items.quantity as item_quantity")
    .order(item_quantity: :desc)
    .order('invoices.created_at desc')
    .first
    .created_at
    .strftime("%m/%d/%Y")
  end
end
