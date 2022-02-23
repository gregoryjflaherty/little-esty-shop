class InvoiceItem < ApplicationRecord
  enum status: ["packaged", "pending", "shipped"]

  belongs_to :item
  belongs_to :invoice
  has_many :merchants, through: :item
  has_many :customers, through: :invoice
  has_many :transactions, through: :invoice

  def self.invoice_created_sorted(merchant)
    binding.pry
    joins(:merchants).where("merchant_id = ?", merchant.id)
      .where("status = ?", 0).order(created_at: :asc)
    #can change number if we want to reference another status, current status is "packaged"
    # where("status = ?", 0).order(created_at: :asc)
  end
end
