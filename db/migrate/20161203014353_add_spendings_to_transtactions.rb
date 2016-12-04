class AddSpendingsToTranstactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :is_spending, :boolean, default: true
  end
end
