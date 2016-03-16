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

ActiveRecord::Schema.define(version: 20160316040010) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,     null: false
    t.integer  "photo_id",   limit: 4,     null: false
    t.text     "message",    limit: 65535, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["photo_id"], name: "index_comments_on_photo_id", using: :btree

  create_table "gifts", force: :cascade do |t|
    t.string   "name",               limit: 191,                                            null: false
    t.text     "description",        limit: 65535
    t.string   "link",               limit: 191
    t.boolean  "purchased",                                                 default: false
    t.string   "image_file_name",    limit: 191
    t.string   "image_content_type", limit: 191
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
    t.decimal  "price",                            precision: 10, scale: 2
  end

  add_index "gifts", ["name"], name: "index_gifts_on_name", using: :btree
  add_index "gifts", ["purchased"], name: "index_gifts_on_purchased", using: :btree

  create_table "guests", force: :cascade do |t|
    t.string   "name",       limit: 191,                 null: false
    t.boolean  "plus_one",               default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "guests", ["name"], name: "index_guests_on_name", unique: true, using: :btree

  create_table "meals", force: :cascade do |t|
    t.string   "name",        limit: 191,   null: false
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "meals", ["name"], name: "index_meals_on_name", using: :btree

  create_table "photos", force: :cascade do |t|
    t.text     "caption",            limit: 65535
    t.string   "source_url",         limit: 255
    t.string   "photographer",       limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id",            limit: 4
    t.string   "avatar",             limit: 191
    t.integer  "source",             limit: 4
    t.string   "instagram_id",       limit: 191
    t.string   "instagram_code",     limit: 191
  end

  add_index "photos", ["created_at"], name: "index_photos_on_created_at", using: :btree
  add_index "photos", ["instagram_id"], name: "index_photos_on_instagram_id", using: :btree

  create_table "recommendations", force: :cascade do |t|
    t.string   "name",               limit: 191,                             null: false
    t.text     "description",        limit: 65535
    t.integer  "category",           limit: 4
    t.string   "address",            limit: 191
    t.string   "link",               limit: 191
    t.string   "image_file_name",    limit: 191
    t.string   "image_content_type", limit: 191
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.decimal  "latitude",                         precision: 15, scale: 10
    t.decimal  "longitude",                        precision: 15, scale: 10
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
  end

  add_index "recommendations", ["name"], name: "index_recommendations_on_name", using: :btree

  create_table "rsvps", force: :cascade do |t|
    t.string   "name",          limit: 191,                  null: false
    t.string   "email",         limit: 191
    t.text     "message",       limit: 65535
    t.boolean  "attending",                   default: true, null: false
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "guest_name",    limit: 191
    t.integer  "meal_id",       limit: 4
    t.integer  "guest_meal_id", limit: 4
  end

  add_index "rsvps", ["name"], name: "index_rsvps_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                limit: 191
    t.string   "token",               limit: 191, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name",    limit: 191
    t.string   "avatar_content_type", limit: 191
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

end
