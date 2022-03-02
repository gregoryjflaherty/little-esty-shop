class Merchant < ApplicationRecord
  enum status: ["enabled", "disabled"]
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true

  def self.top_five_by_revenue
    joins(:items, :invoices, :transactions)
      .where(transactions: {result: :success})
      .select('merchants.name, merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group('merchants.id')
      .order(revenue: :desc).distinct.limit(5)
  end

  def top_five_customers
    customers.joins(:invoices, :transactions)
      .where('transactions.result = ?', 1)
      .group('customers.id')
      .select('customers.*, count(*) AS transaction_count')
      .order('transaction_count DESC')
      .limit(5)
  end

  def top_five_items
    items.joins(invoice_items: {invoice: :transactions})
    .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_rev")
    .group("invoice_items.item_id")
    .group("items.id")
    .order("total_rev DESC")
    .limit(5)
  end

  def items_not_shipped
    items.joins(invoice_items: :invoice)
    .select("items.*, invoices.created_at AS invoice_created, invoices.id AS invoice_id")
    .where.not("invoice_items.status = ?", 2)
    .order("invoices.created_at ASC")
  end

  def enabled_disabled_items(status)
    items.where(enabled: status)
  end

  def best_revenue_day
    invoices.select('invoices.created_at, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
            .group('invoices.created_at').order(total_revenue: :desc)
            .limit(1)[0].creation_date_formatted
  end

  def self.disabled
    where(status: 1)
  end

  def self.enabled
    where(status: 0)
  end
end
