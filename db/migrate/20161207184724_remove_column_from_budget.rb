class RemoveColumnFromBudget < ActiveRecord::Migration[5.0]
  def change
    remove_column :budgets, :budget_type
    remove_column :budgets, :budget_period
  end
end
