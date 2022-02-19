class Invoice < ApplicationRecord
  enum status: ["cancelled", "completed", "in progress"]

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  
end
