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

ActiveRecord::Schema.define(version: 20150625121038) do

  create_table "admin_messages", force: :cascade do |t|
    t.string   "title"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "admin_messages", ["user_id"], name: "index_admin_messages_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.boolean  "soft_delete"
    t.date     "soft_delete_date"
    t.string   "text"
    t.boolean  "hidden"
    t.integer  "empathy_level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "user_id"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "fact_types", force: :cascade do |t|
    t.string   "fact_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres", force: :cascade do |t|
    t.string   "genre_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "fact_link"
    t.string   "fiction_link"
    t.string   "post_name"
    t.integer  "importance"
    t.string   "text"
    t.boolean  "soft_delete"
    t.date     "soft_delete_date"
    t.boolean  "hidden"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "fact_type_id"
    t.integer  "genre_id"
    t.integer  "topic_id"
    t.integer  "categorie_id"
  end

  add_index "posts", ["categorie_id"], name: "index_posts_on_categorie_id"
  add_index "posts", ["fact_type_id"], name: "index_posts_on_fact_type_id"
  add_index "posts", ["genre_id"], name: "index_posts_on_genre_id"
  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "topics", force: :cascade do |t|
    t.string   "topic_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "display_name"
    t.date     "date_of_birth"
    t.integer  "gender"
    t.integer  "facebook_id"
    t.string   "twitter_url"
    t.string   "personal_message"
    t.string   "webpage_url"
    t.boolean  "is_banned"
    t.date     "is_banned_date"
    t.integer  "number_of_posts"
    t.integer  "number_of_comments"
    t.boolean  "legal_terms_read"
    t.boolean  "privacy_terms_read"
    t.boolean  "is_superUser"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
