class Transaction < ApplicationRecord
  belongs_to :budget
  belongs_to :category

  validates :amount, presence: true, numericality: { other_than: 0 }
  validates :description, presence: true, length: { minimum: 1, maximum: 500 }
  validates :date, presence: true

  validate :date_within_budget_period

  scope :income, -> { joins(:category).where(categories: { category_type: "income" }) }
  scope :expenses, -> { joins(:category).where(categories: { category_type: "expense" }) }
  scope :by_date, -> { order(:date) }
  scope :recent, -> { order(date: :desc) }
  scope :for_month, ->(month, year) { where(date: Date.new(year, month, 1).beginning_of_month..Date.new(year, month, 1).end_of_month) }

  def income?
    category.income?
  end

  def expense?
    category.expense?
  end

  def formatted_amount
    ActionController::Base.helpers.number_to_currency(amount.abs)
  end

  def amount_with_sign
    income? ? "+#{formatted_amount}" : "-#{formatted_amount}"
  end

  def amount_class
    income? ? "text-green-600" : "text-red-600"
  end

  private

  def date_within_budget_period
    return unless budget && date

    unless date.between?(budget.start_date, budget.end_date)
      errors.add(:date, "must be within the budget period")
    end
  end
end
