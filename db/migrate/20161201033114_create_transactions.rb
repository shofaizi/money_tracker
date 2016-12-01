class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.integer :amount_cents
      t.date :transaction_date
      t.text :description
      t.text :location
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
