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

ActiveRecord::Schema.define(version: 20161023230056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "discussion_id", null: false
    t.text     "message",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["discussion_id"], name: "index_comments_on_discussion_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "discussion_entries", force: :cascade do |t|
    t.integer  "discussion_id",    null: false
    t.string   "discussable_type"
    t.integer  "discussable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["discussable_type", "discussable_id"], name: "index_discussion_entries_on_discussable_type_and_discussable_id", using: :btree
    t.index ["discussion_id"], name: "index_discussion_entries_on_discussion_id", using: :btree
  end

  create_table "discussions", force: :cascade do |t|
    t.integer  "user_id",                    null: false
    t.string   "title",                      null: false
    t.string   "token",                      null: false
    t.boolean  "private",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["token"], name: "index_discussions_on_token", unique: true, using: :btree
    t.index ["user_id"], name: "index_discussions_on_user_id", using: :btree
  end

  create_table "poll_options", force: :cascade do |t|
    t.integer  "poll_id",                null: false
    t.string   "value",                  null: false
    t.integer  "position",   default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["poll_id"], name: "index_poll_options_on_poll_id", using: :btree
  end

  create_table "polls", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "discussion_id", null: false
    t.string   "title",         null: false
    t.datetime "locked_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["discussion_id"], name: "index_polls_on_discussion_id", using: :btree
    t.index ["user_id"], name: "index_polls_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "display_name",           default: "", null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
