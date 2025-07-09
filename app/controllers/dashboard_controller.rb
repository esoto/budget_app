class DashboardController < ApplicationController
  def index
    @current_budget = Budget.active.first || Budget.by_date.last
    @recent_transactions = recent_transactions
    @spending_by_category = spending_by_category
    @income_vs_expenses = income_vs_expenses
    @monthly_stats = monthly_stats
  end

  private

  def recent_transactions
    return Transaction.none unless @current_budget

    @current_budget.transactions
                   .includes(:category)
                   .recent
                   .limit(10)
  end

  def spending_by_category
    return {} unless @current_budget

    @current_budget.transactions
                   .joins(:category)
                   .where(categories: { category_type: "expense" })
                   .group("categories.name", "categories.color")
                   .sum(:amount)
  end

  def income_vs_expenses
    return { income: 0, expenses: 0 } unless @current_budget

    transactions = @current_budget.transactions.includes(:category)

    {
      income: transactions.select { |t| t.category.income? }.sum(&:amount),
      expenses: transactions.select { |t| t.category.expense? }.sum(&:amount)
    }
  end

  def monthly_stats
    return {} unless @current_budget

    {
      total_budget: @current_budget.total_amount,
      total_spent: @current_budget.total_spent,
      remaining: @current_budget.remaining_amount,
      percentage_used: @current_budget.percentage_used,
      days_remaining: (@current_budget.end_date - Date.current).to_i,
      total_days: (@current_budget.end_date - @current_budget.start_date).to_i + 1
    }
  end
end
