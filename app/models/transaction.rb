class Transaction < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :budgets

  validates :transaction_type, presence: true
  validates :amount_cents, presence: true, numericality: true
  validates :transaction_date, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  # validates :location, presence: true, length: { minimum: 5 }

  def set_spending_type
    if self.is_spending
      self.amount_cents = (self.amount_cents * -1)
    end
  end

  def self.balance(user,date)
    credit_txns = where('user_id = ? AND is_spending = ? AND transaction_date = ?', user.id, false, date)
    debit_txns  = where('user_id = ? AND is_spending = ? AND transaction_date = ?', user.id, true, date)
    sum_of_credit_txns = credit_txns.map(&:amount_cents).reduce(&:+) || 0
    sum_of_debit_txns  = debit_txns.map(&:amount_cents).reduce(&:+)  || 0
    actual             = (sum_of_credit_txns - sum_of_debit_txns)/100
  end
end
