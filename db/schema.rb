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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111128012156) do

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"

  create_table "ideas", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "state_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "invites", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.integer  "idea_id"
    t.boolean  "can_edit",   :default => false
    t.string   "token"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "idea_id"
    t.boolean  "can_edit",             :default => false
    t.boolean  "notification_version", :default => true
    t.boolean  "notification_comment", :default => true
    t.boolean  "weekly_status",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.integer  "idea_id"
    t.text     "description", :limit => 255
    t.boolean  "locked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "custom",                     :default => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.boolean  "internal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.integer  "section_id"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
