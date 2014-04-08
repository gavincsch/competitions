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

ActiveRecord::Schema.define(version: 20140126190827) do

  create_table "competitions", force: true do |t|
    t.string   "campaign"
    t.string   "campaign_url"
    t.datetime "date_from"
    t.datetime "date_to"
    t.string   "enter_image"
    t.string   "thankyou_image"
    t.boolean  "birthday"
    t.boolean  "likes_sports"
    t.boolean  "has_kids"
    t.integer  "entries",        default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",         default: false
  end

  create_table "entries", force: true do |t|
    t.string   "firstname"
    t.string   "surname"
    t.string   "email"
    t.integer  "mobile"
    t.string   "region"
    t.date     "dob"
    t.integer  "gender"
    t.boolean  "newsletter",     default: false
    t.string   "source"
    t.boolean  "q1",             default: false
    t.boolean  "q2",             default: false
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", force: true do |t|
    t.string   "album_name"
    t.integer  "image_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries", ["album_name"], name: "index_galleries_on_album_name", using: :btree

  create_table "images", force: true do |t|
    t.string   "images"
    t.string   "image_name"
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["image_name"], name: "index_images_on_image_name", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "hashed_password", limit: 40
    t.string   "salt",            limit: 40
    t.boolean  "admin",                      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
