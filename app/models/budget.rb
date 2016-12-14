class Budget < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :budget_transactions, class_name: 'Transaction'

  monetize :goal_amount_cents

  def current_amount_cents
    case period
    when "monthly"
      budget_transactions.where(transaction_date: Date.today.beginning_of_month..Date.today.end_of_month).reduce(0) {
        |sum, t| sum += t.amount_cents
      }
    when "weekly"
      budget_transactions.where(transaction_date: Date.today.beginning_of_week..Date.today.end_of_week).reduce(0) {
        |sum, t| sum += t.amount_cents
      }
    else
      #do something here?
    end
  end

  def current_percentage
    (current_amount_cents.to_f / goal_amount_cents.to_f) * 100
  end
end
