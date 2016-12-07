class Budget < ApplicationRecord
  belongs_to :user
  has_many :entries
  
  validates :goal_amount_cents, presence: true, numericality: true
end
