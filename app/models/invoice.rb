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

  def creation_date_formatted
    date = self.created_at
    date.strftime("%A, %B %d, %Y")
  end

  def items_by_merchant(merchant_id)
    items.joins(:invoice_items)
      .where('merchant_id = ?', merchant_id)
  end
  
  def self.oldest_to_newest
    order(:created_at)
  end
end
