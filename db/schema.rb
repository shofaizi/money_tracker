# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161210191838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "period"
    t.integer  "goal_amount_cents"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["user_id"], name: "index_budgets_on_user_id", using: :btree
  end

  create_table "budgets_transactions", id: false, force: :cascade do |t|
    t.integer "budget_id"
    t.integer "transaction_id"
    t.index ["budget_id"], name: "index_budgets_transactions_on_budget_id", using: :btree
    t.index ["transaction_id"], name: "index_budgets_transactions_on_transaction_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "transaction_type"
    t.integer  "amount_cents"
    t.date     "transaction_date"
    t.text     "description"
    t.text     "location"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_spending",      default: true
    t.index ["user_id"], name: "index_transactions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "uid"
    t.string   "provider"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.text     "oauth_raw_data"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", using: :btree
  end

  add_foreign_key "budgets", "users"
  add_foreign_key "transactions", "users"
end
