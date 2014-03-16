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

ActiveRecord::Schema.define(version: 20140316110445) do

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.text     "content"
    t.boolean  "is_correct",  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.boolean  "expires"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider"], name: "index_authentications_on_provider", using: :btree
  add_index "authentications", ["uid"], name: "index_authentications_on_uid", unique: true, using: :btree

  create_table "games", force: true do |t|
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.integer  "score",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_quizzes", id: false, force: true do |t|
    t.integer "question_id"
    t.integer "quiz_id"
  end

  create_table "questions_topics", id: false, force: true do |t|
    t.integer "question_id"
    t.integer "topic_id"
  end

  create_table "quizzes", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.date     "date"
    t.string   "type"
    t.string   "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quizzes", ["type"], name: "index_quizzes_on_type", using: :btree
  add_index "quizzes", ["workflow_state"], name: "index_quizzes_on_workflow_state", using: :btree

  create_table "replies", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.boolean  "is_correct",  default: false
    t.integer  "timer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["depth"], name: "index_topics_on_depth", using: :btree
  add_index "topics", ["lft"], name: "index_topics_on_lft", using: :btree
  add_index "topics", ["parent_id"], name: "index_topics_on_parent_id", using: :btree
  add_index "topics", ["rgt"], name: "index_topics_on_rgt", using: :btree
  add_index "topics", ["workflow_state"], name: "index_topics_on_workflow_state", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
