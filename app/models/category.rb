class Category < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 50 }
  validates :category_type, presence: true, inclusion: { in: %w[income expense] }
  validates :color, presence: true, format: { with: /\A#[0-9A-Fa-f]{6}\z/, message: "must be a valid hex color" }

  scope :income, -> { where(category_type: "income") }
  scope :expense, -> { where(category_type: "expense") }
  scope :by_name, -> { order(:name) }

  def income?
    category_type == "income"
  end

  def expense?
    category_type == "expense"
  end

  def total_amount_for_budget(budget)
    transactions.where(budget: budget).sum(:amount)
  end

  def self.default_income_categories
    [
      { name: "Salary", category_type: "income", color: "#10B981" },
      { name: "Freelance", category_type: "income", color: "#059669" },
      { name: "Investment", category_type: "income", color: "#047857" },
      { name: "Other Income", category_type: "income", color: "#065F46" }
    ]
  end

  def self.default_expense_categories
    [
      { name: "Food & Dining", category_type: "expense", color: "#EF4444" },
      { name: "Transportation", category_type: "expense", color: "#F97316" },
      { name: "Housing", category_type: "expense", color: "#EAB308" },
      { name: "Utilities", category_type: "expense", color: "#8B5CF6" },
      { name: "Healthcare", category_type: "expense", color: "#EC4899" },
      { name: "Entertainment", category_type: "expense", color: "#06B6D4" },
      { name: "Shopping", category_type: "expense", color: "#84CC16" },
      { name: "Other Expenses", category_type: "expense", color: "#6B7280" }
    ]
  end
end
