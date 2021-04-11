# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_10_154158) do

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cat_name"
  end

  create_table "clients", force: :cascade do |t|
    t.string "sex"
    t.string "city"
    t.string "name"
    t.string "email"
    t.string "address"
    t.datetime "dateofbirth"
    t.string "creditCard"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "mobile"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "category_id", null: false
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "client_id", null: false
    t.integer "item_id", null: false
    t.index ["client_id"], name: "index_order_items_on_client_id"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "client_id", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
  end

  add_foreign_key "items", "categories"
  add_foreign_key "order_items", "clients"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "clients"
end
