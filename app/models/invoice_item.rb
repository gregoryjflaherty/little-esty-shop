class InvoiceItem < ApplicationRecord
  enum status: ["packaged", "pending", "shipped"]

  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :customers, through: :invoice
  has_many :transactions, through: :invoice

  def invoice_creation_date
    invoice.creation_date_formatted
  end

  def self.revenue
      sum('quantity * unit_price')
  end

end
