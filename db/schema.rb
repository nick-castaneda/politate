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

ActiveRecord::Schema.define(version: 20160106033803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annotations", force: :cascade do |t|
    t.string   "comment"
    t.string   "link"
    t.integer  "user_id"
    t.integer  "transcript_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "start"
    t.integer  "end"
  end

  add_index "annotations", ["transcript_id"], name: "index_annotations_on_transcript_id", using: :btree
  add_index "annotations", ["user_id"], name: "index_annotations_on_user_id", using: :btree

  create_table "parties", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "parties", ["user_id"], name: "index_parties_on_user_id", using: :btree

  create_table "transcripts", force: :cascade do |t|
    t.string   "title"
    t.date     "date"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transcripts", ["user_id", "created_at"], name: "index_transcripts_on_user_id_and_created_at", using: :btree
  add_index "transcripts", ["user_id"], name: "index_transcripts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.integer  "party_id"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "prof_pic_url"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "annotations", "transcripts"
  add_foreign_key "annotations", "users"
  add_foreign_key "parties", "users"
  add_foreign_key "transcripts", "users"
end
