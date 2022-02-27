class Invoice < ApplicationRecord
  enum status: ["cancelled", "completed", "in progress"]

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.incomplete_invoices
    joins(:invoice_items).where('invoice_items.status != ?', 2).distinct
  end
end
