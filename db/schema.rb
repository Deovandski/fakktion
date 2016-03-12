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

ActiveRecord::Schema.define(version: 20150628051759) do

  create_table "admin_messages", force: :cascade do |t|
    t.string   "title"
    t.string   "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "admin_messages", ["user_id"], name: "index_admin_messages_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string  "name"
    t.integer "posts_count", default: 0
  end

  create_table "comments", force: :cascade do |t|
    t.string   "text"
    t.integer  "empathy_level",        default: 0
    t.boolean  "hidden",               default: false
    t.integer  "inner_comments_count", default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "post_id"
    t.integer  "user_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "fact_types", force: :cascade do |t|
    t.string  "name"
    t.integer "eligibility_counter", default: 0
    t.integer "posts_count",         default: 0
  end

  create_table "genres", force: :cascade do |t|
    t.string  "name"
    t.integer "eligibility_counter", default: 0
    t.integer "posts_count",         default: 0
  end

  create_table "inner_comments", force: :cascade do |t|
    t.string   "text"
    t.integer  "empathy_level", default: 0
    t.boolean  "hidden",        default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "comment_id"
    t.integer  "user_id"
  end

  add_index "inner_comments", ["comment_id"], name: "index_inner_comments_on_comment_id"
  add_index "inner_comments", ["user_id"], name: "index_inner_comments_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.string   "fact_link"
    t.string   "fiction_link"
    t.string   "title"
    t.string   "text"
    t.integer  "importance",     default: 0
    t.integer  "comments_count", default: 0
    t.integer  "views_count",    default: 0
    t.boolean  "hidden"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.integer  "fact_type_id"
    t.integer  "genre_id"
    t.integer  "topic_id"
    t.integer  "category_id"
  end

  add_index "posts", ["category_id"], name: "index_posts_on_category_id"
  add_index "posts", ["fact_type_id"], name: "index_posts_on_fact_type_id"
  add_index "posts", ["genre_id"], name: "index_posts_on_genre_id"
  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "topics", force: :cascade do |t|
    t.string  "name"
    t.integer "eligibility_counter", default: 0
    t.integer "posts_count",         default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "display_name"
    t.string   "facebook_url",           default: ""
    t.string   "twitter_url",            default: ""
    t.string   "personal_message",       default: ""
    t.string   "webpage_url",            default: ""
    t.date     "date_of_birth"
    t.date     "is_banned_date"
    t.integer  "gender"
    t.integer  "admin_messages_count",   default: 0
    t.integer  "posts_count",            default: 0
    t.integer  "comments_count",         default: 0
    t.boolean  "is_banned",              default: false
    t.integer  "times_banned",           default: 0
    t.boolean  "legal_terms_read",       default: false
    t.boolean  "privacy_terms_read",     default: false
    t.boolean  "is_super_user",          default: false
    t.boolean  "is_admin",               default: false
    t.boolean  "show_full_name",         default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
