class Transaction < ApplicationRecord
  enum result: ["failed", "success"]

  belongs_to :invoice
  has_many :customers, through: :invoices
end
