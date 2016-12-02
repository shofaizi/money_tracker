class Budget < ApplicationRecord
  belongs_to :user

  validates :budget_type, presence: true
  validates :budget_period, presence: true
  validates :goal_amount_cents, presence: true, numericality: true
end
