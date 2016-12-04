class Transaction < ApplicationRecord
  # before_save :set_spending_type
  # before_save :set_transaction_type

  belongs_to :user

  # validates :transaction_type, presence: true
  validates :amount_cents, presence: true, numericality: true
  validates :transaction_date, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  # validates :location, presence: true, length: { minimum: 5 }

  def set_spending_type
    if self.is_spending
      self.amount_cents = (self.amount_cents * -1)
    end
  end

  # def set_transaction_type
  #   if self.is_spending
  #     self.amount_cents = (self.amount_cents * -1)
  #   end
  # end
end
