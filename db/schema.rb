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

ActiveRecord::Schema.define(version: 20160317073022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcement_photos", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "announcement_id"
  end

  add_index "announcement_photos", ["announcement_id"], name: "index_announcement_photos_on_announcement_id", using: :btree

  create_table "announcements", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.boolean  "seeable",    default: false
    t.string   "slug"
  end

  add_index "announcements", ["slug"], name: "index_announcements_on_slug", unique: true, using: :btree
  add_index "announcements", ["user_id"], name: "index_announcements_on_user_id", using: :btree

  create_table "booking_slots", force: :cascade do |t|
    t.integer  "time_slot"
    t.boolean  "bookable"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.date     "booking_date"
    t.boolean  "is_booked",    default: false
    t.integer  "booking_type", default: 0
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "comments", ["message_id"], name: "index_comments_on_message_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.boolean  "anonymous"
    t.boolean  "seeable",    default: false
    t.string   "slug"
  end

  add_index "messages", ["slug"], name: "index_messages_on_slug", unique: true, using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "post_photos", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "post_id"
  end

  add_index "post_photos", ["post_id"], name: "index_post_photos_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "category_id"
    t.integer  "user_id"
    t.boolean  "seeable",     default: false
    t.string   "slug"
  end

  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "booking_slot_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.string   "desc"
  end

  add_index "reservations", ["booking_slot_id"], name: "index_reservations_on_booking_slot_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "upload_photos", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.string   "size"
    t.string   "content_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "password_digest"
    t.boolean  "admin"
    t.boolean  "verified"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "pin"
    t.string   "email"
    t.string   "home_pre"
    t.string   "home_post"
    t.boolean  "black",           default: false
    t.date     "black_date"
    t.string   "slug"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  add_foreign_key "comments", "messages"
  add_foreign_key "reservations", "booking_slots"
end
