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
end
