# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150512140213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "surname"
    t.string   "name"
    t.string   "company"
    t.string   "pesel"
    t.string   "regon"
    t.string   "telephone_number"
    t.string   "e_mail"
    t.string   "street"
    t.string   "city"
    t.string   "zip_code"
    t.text     "comments"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "activity"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "installments", force: :cascade do |t|
    t.integer  "instable_id"
    t.string   "instable_type"
    t.decimal  "amount",        precision: 8, scale: 2
    t.datetime "pay_date"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "paid"
  end

  add_index "installments", ["instable_type", "instable_id"], name: "index_installments_on_instable_type_and_instable_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "group_id"
  end

  add_index "items", ["group_id"], name: "index_items_on_group_id", using: :btree

  create_table "items_material_policies", force: :cascade do |t|
    t.integer  "material_policy_id"
    t.integer  "item_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "items_material_policies", ["item_id"], name: "index_items_material_policies_on_item_id", using: :btree
  add_index "items_material_policies", ["material_policy_id"], name: "index_items_material_policies_on_material_policy_id", using: :btree

  create_table "material_policies", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "group_id"
    t.string   "number"
    t.datetime "sign_date"
    t.datetime "begin_date"
    t.datetime "expire_date"
    t.text     "comments"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "contribution", precision: 8, scale: 2
    t.decimal  "sum",          precision: 8, scale: 2
  end

  add_index "material_policies", ["client_id"], name: "index_material_policies_on_client_id", using: :btree
  add_index "material_policies", ["group_id"], name: "index_material_policies_on_group_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "items", "groups"
end
