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

  def self.top_five_customers
    joins(:invoices, :transactions)
      .where('transactions.result = ?', 1)
      .group('customers.id')
      .select('customers.*, count(*) AS transaction_count')
      .order('transaction_count DESC')
      .limit(5)
  end
end
