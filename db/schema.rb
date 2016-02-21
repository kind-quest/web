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

ActiveRecord::Schema.define(version: 20160221033422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "act_views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "act_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "act_views", ["act_id"], name: "index_act_views_on_act_id", using: :btree
  add_index "act_views", ["user_id"], name: "index_act_views_on_user_id", using: :btree

  create_table "acts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acts", ["user_id"], name: "index_acts_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "act_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["act_id"], name: "index_likes_on_act_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "act_views", "acts"
  add_foreign_key "act_views", "users"
  add_foreign_key "acts", "users"
  add_foreign_key "likes", "acts"
  add_foreign_key "likes", "users"
end
