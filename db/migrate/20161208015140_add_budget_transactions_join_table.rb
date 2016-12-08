class AddBudgetTransactionsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :budgets_transactions, id: false do |t|
      t.belongs_to :budget, index: true
      t.belongs_to :transaction, index: true
    end
  end
end
