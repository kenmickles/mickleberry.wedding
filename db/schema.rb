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

ActiveRecord::Schema.define(version: 20160213204511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "photo_id",   null: false
    t.text     "message",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["photo_id"], name: "index_comments_on_photo_id", using: :btree

  create_table "gifts", force: :cascade do |t|
    t.string   "name",                                                        null: false
    t.text     "description"
    t.string   "link"
    t.boolean  "purchased",                                   default: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.decimal  "price",              precision: 10, scale: 2
  end

  add_index "gifts", ["name"], name: "index_gifts_on_name", using: :btree
  add_index "gifts", ["purchased"], name: "index_gifts_on_purchased", using: :btree

  create_table "guests", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "plus_one",   default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "guests", ["name"], name: "index_guests_on_name", unique: true, using: :btree

  create_table "meals", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "meals", ["name"], name: "index_meals_on_name", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "caption"
    t.string   "source_url"
    t.string   "photographer"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.string   "avatar"
    t.integer  "source"
    t.string   "instagram_id"
    t.string   "instagram_code"
  end

  add_index "photos", ["created_at"], name: "index_photos_on_created_at", using: :btree
  add_index "photos", ["instagram_id"], name: "index_photos_on_instagram_id", using: :btree

  create_table "recommendations", force: :cascade do |t|
    t.string   "name",                                         null: false
    t.text     "description"
    t.integer  "category"
    t.string   "address"
    t.string   "link"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "latitude",           precision: 15, scale: 10
    t.decimal  "longitude",          precision: 15, scale: 10
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "recommendations", ["name"], name: "index_recommendations_on_name", using: :btree

  create_table "rsvps", force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "email"
    t.text     "message"
    t.boolean  "attending",     default: true, null: false
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "guest_name"
    t.integer  "meal_id"
    t.integer  "guest_meal_id"
  end

  add_index "rsvps", ["name"], name: "index_rsvps_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "token",               null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

end
