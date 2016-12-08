json.extract! budget, :id, :name, :description, :period, :goal_amount_cents, :user_id, :created_at, :updated_at
json.url budget_url(budget, format: :json)