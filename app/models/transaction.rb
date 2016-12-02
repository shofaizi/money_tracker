class Transaction < ApplicationRecord
  belongs_to :user

  validates :transaction_type, presence: true
  validates :amount_cents, presence: true, numericality: true
  validates :transaction_date, presence: true,
  validates :description, presence: true, length: { minimum: 5 }
  validates :location, presence: true, length: { minimum: 5 }
end
