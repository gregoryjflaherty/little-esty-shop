class InvoiceItem < ApplicationRecord
  enum status: ["packaged", "pending", "shipped"]

  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :customers, through: :invoice
  has_many :transactions, through: :invoice
end
