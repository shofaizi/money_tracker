class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.string :type
      t.date :period
      t.integer :amount_cents
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
