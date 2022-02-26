class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def successful_transactions_count
    invoices.where(status: :completed).count
  end

  def full_name
    (self.first_name) + " " + (self.last_name)
  end
end
