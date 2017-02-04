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

ActiveRecord::Schema.define(version: 20160612084640) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.text     "content",     limit: 65535
    t.boolean  "is_correct",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "provider",      limit: 255
    t.string   "uid",           limit: 255
    t.string   "token",         limit: 255
    t.string   "refresh_token", limit: 255
    t.datetime "expires_at"
    t.boolean  "expires"
    t.string   "image",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider"], name: "index_authentications_on_provider", using: :btree
  add_index "authentications", ["uid"], name: "index_authentications_on_uid", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255, null: false
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "quiz_id",        limit: 4
    t.integer  "score",          limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "workflow_state", limit: 255
  end

  add_index "games", ["workflow_state"], name: "index_games_on_workflow_state", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_quizzes", id: false, force: :cascade do |t|
    t.integer "question_id", limit: 4
    t.integer "quiz_id",     limit: 4
  end

  create_table "questions_topics", id: false, force: :cascade do |t|
    t.integer "question_id", limit: 4
    t.integer "topic_id",    limit: 4
  end

  create_table "quizzes", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "description",    limit: 255
    t.date     "date"
    t.string   "type",           limit: 255
    t.string   "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quizzes", ["type"], name: "index_quizzes_on_type", using: :btree
  add_index "quizzes", ["workflow_state"], name: "index_quizzes_on_workflow_state", using: :btree

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "game_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.integer  "answer_id",   limit: 4
    t.boolean  "is_correct",            default: false
    t.integer  "time",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "description",    limit: 255
    t.integer  "parent_id",      limit: 4
    t.integer  "lft",            limit: 4
    t.integer  "rgt",            limit: 4
    t.integer  "depth",          limit: 4
    t.string   "workflow_state", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["depth"], name: "index_topics_on_depth", using: :btree
  add_index "topics", ["lft"], name: "index_topics_on_lft", using: :btree
  add_index "topics", ["parent_id"], name: "index_topics_on_parent_id", using: :btree
  add_index "topics", ["rgt"], name: "index_topics_on_rgt", using: :btree
  add_index "topics", ["workflow_state"], name: "index_topics_on_workflow_state", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "daily_quiz_score",       limit: 4,   default: 0
    t.string   "title",                  limit: 255
    t.integer  "xp_points",              limit: 4,   default: 0
    t.integer  "level",                  limit: 4,   default: 1
    t.string   "authentication_token",   limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
