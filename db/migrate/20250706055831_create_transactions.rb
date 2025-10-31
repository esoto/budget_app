class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.text :description, null: false
      t.date :date, null: false
      t.references :budget, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :transactions, :date
    add_index :transactions, [ :budget_id, :date ]
    add_index :transactions, [ :category_id, :date ]
    add_index :transactions, [ :budget_id, :category_id ]
  end
end
