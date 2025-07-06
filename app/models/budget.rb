class Budget < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 100 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :total_amount, presence: true, numericality: { greater_than: 0 }

  validate :end_date_after_start_date

  scope :active, -> { where("start_date <= ? AND end_date >= ?", Date.current, Date.current) }
  scope :by_date, -> { order(:start_date) }

  def active?
    Date.current.between?(start_date, end_date)
  end

  def total_spent
    transactions.sum(:amount)
  end

  def remaining_amount
    total_amount - total_spent
  end

  def percentage_used
    return 0 if total_amount.zero?
    (total_spent / total_amount * 100).round(2)
  end

  private

  def end_date_after_start_date
    return unless start_date && end_date

    errors.add(:end_date, "must be after start date") if end_date < start_date
  end
end
