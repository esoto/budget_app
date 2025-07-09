# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_06_055831) do
  create_table "budgets", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.decimal "total_amount", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_date"], name: "index_budgets_on_end_date"
    t.index ["start_date", "end_date"], name: "index_budgets_on_start_date_and_end_date"
    t.index ["start_date"], name: "index_budgets_on_start_date"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "category_type"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.text "description", null: false
    t.date "date", null: false
    t.integer "budget_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_id", "category_id"], name: "index_transactions_on_budget_id_and_category_id"
    t.index ["budget_id", "date"], name: "index_transactions_on_budget_id_and_date"
    t.index ["budget_id"], name: "index_transactions_on_budget_id"
    t.index ["category_id", "date"], name: "index_transactions_on_category_id_and_date"
    t.index ["category_id"], name: "index_transactions_on_category_id"
    t.index ["date"], name: "index_transactions_on_date"
  end

  add_foreign_key "transactions", "budgets"
  add_foreign_key "transactions", "categories"
end
