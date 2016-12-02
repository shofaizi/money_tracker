class CreateBudgets < ActiveRecord::Migration[5.0]
  def change
    create_table :budgets do |t|
      t.string :budget_type
      t.date :budget_period
      t.integer :goal_amount_cents
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
