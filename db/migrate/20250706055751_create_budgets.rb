class CreateBudgets < ActiveRecord::Migration[8.0]
  def change
    create_table :budgets do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :budgets, :start_date
    add_index :budgets, :end_date
    add_index :budgets, [ :start_date, :end_date ]
  end
end
