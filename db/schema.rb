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

ActiveRecord::Schema.define(:version => 20120126151538) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "automatic",                                   :default => false
    t.decimal  "time_digit",    :precision => 6, :scale => 1, :default => 2.0
    t.string   "time_unit",                                   :default => "hours"
    t.datetime "publish_from"
    t.datetime "publish_until"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
  end

  create_table "statuses", :force => true do |t|
    t.integer  "user_id"
    t.string   "status",        :null => false
    t.string   "twitter_id"
    t.string   "response_code"
    t.datetime "scheduled_at"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nickname"
    t.string   "name"
    t.datetime "remember_created_at"
    t.string   "remember_token"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
