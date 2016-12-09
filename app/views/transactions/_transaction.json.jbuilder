json.extract! transaction, :id, :transaction_type, :amount_cents, :transaction_date, :description, :user_id, :is_spending, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
