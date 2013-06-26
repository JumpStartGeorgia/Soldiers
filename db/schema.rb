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

ActiveRecord::Schema.define(:version => 20130626090631) do

  create_table "soldier_translations", :force => true do |t|
    t.integer  "soldier_id"
    t.string   "locale"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "place_from"
    t.string   "rank"
    t.string   "served_with"
    t.string   "country_died"
    t.string   "place_died"
    t.string   "incident_type"
    t.string   "incident_description"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "soldier_translations", ["country_died"], :name => "index_soldier_translations_on_country_died"
  add_index "soldier_translations", ["incident_description"], :name => "index_soldier_translations_on_incident_description"
  add_index "soldier_translations", ["incident_type"], :name => "index_soldier_translations_on_incident_type"
  add_index "soldier_translations", ["locale"], :name => "index_soldier_translations_on_locale"
  add_index "soldier_translations", ["place_died"], :name => "index_soldier_translations_on_place_died"
  add_index "soldier_translations", ["place_from"], :name => "index_soldier_translations_on_place_from"
  add_index "soldier_translations", ["rank"], :name => "index_soldier_translations_on_rank"
  add_index "soldier_translations", ["served_with"], :name => "index_soldier_translations_on_served_with"
  add_index "soldier_translations", ["soldier_id"], :name => "index_soldier_translations_on_soldier_id"

  create_table "soldiers", :force => true do |t|
    t.string   "born_at"
    t.date     "died_at"
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_male",             :default => true
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.string   "img_bw_file_name"
    t.string   "img_bw_content_type"
    t.integer  "img_bw_file_size"
    t.datetime "img_bw_updated_at"
  end

  add_index "soldiers", ["died_at"], :name => "index_soldiers_on_died_at"
  add_index "soldiers", ["is_male"], :name => "index_soldiers_on_is_male"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.integer  "role",                   :default => 0,  :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
