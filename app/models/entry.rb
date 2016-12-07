class Entry < ApplicationRecord
  belongs_to :budgets

  validates :type, presence: true, length: {minimum: 5}
  validates :period, presence: true
  validates :amount_cents, presence: true, numericality: true
end
