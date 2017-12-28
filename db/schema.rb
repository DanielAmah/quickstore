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

ActiveRecord::Schema.define(version: 20171308182853) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_status_codes", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.date "date"
    t.text "description"
    t.bigint "order_id"
    t.bigint "invoice_status_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_status_code_id"], name: "index_invoices_on_invoice_status_code_id"
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "order_item_status_codes", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.float "price"
    t.string "RMA_number"
    t.date "RMA_date"
    t.text "description"
    t.bigint "product_id"
    t.bigint "order_id"
    t.bigint "order_item_status_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["order_item_status_code_id"], name: "index_order_items_on_order_item_status_code_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_status_codes", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.date "date"
    t.text "description"
    t.bigint "order_status_code_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_status_code_id"], name: "index_orders_on_order_status_code_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.date "date"
    t.float "amount"
    t.bigint "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "color"
    t.integer "size"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "shipment_items", force: :cascade do |t|
    t.bigint "shipment_id"
    t.bigint "order_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_id"], name: "index_shipment_items_on_order_item_id"
    t.index ["shipment_id"], name: "index_shipment_items_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.string "tracking_number"
    t.date "date"
    t.text "description"
    t.bigint "order_id"
    t.bigint "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_shipments_on_invoice_id"
    t.index ["order_id"], name: "index_shipments_on_order_id"
  end

  add_foreign_key "invoices", "invoice_status_codes"
  add_foreign_key "invoices", "orders"
  add_foreign_key "order_items", "order_item_status_codes"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "order_status_codes"
  add_foreign_key "payments", "invoices"
  add_foreign_key "products", "categories"
  add_foreign_key "shipment_items", "order_items"
  add_foreign_key "shipment_items", "shipments"
  add_foreign_key "shipments", "invoices"
  add_foreign_key "shipments", "orders"
end
