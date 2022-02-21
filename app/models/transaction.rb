class Transaction < ApplicationRecord
  enum result: ["failed", "success"]

  belongs_to :invoice
  has_many :customers, through: :invoice
  has_many :invoice_items, through: :invoice
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
end
