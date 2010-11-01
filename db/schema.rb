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

ActiveRecord::Schema.define(:version => 20101026212914) do

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "invited_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitees", :force => true do |t|
    t.integer  "night_id",        :null => false
    t.string   "email",           :null => false
    t.string   "access_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "attending"
    t.integer  "invited_user_id"
  end

  create_table "locations", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "disabled",   :default => false, :null => false
  end

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.string   "alt_title"
    t.float    "popularity"
    t.string   "tmdb_id"
    t.string   "imdb_id"
    t.datetime "release"
    t.text     "posters"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nights", :force => true do |t|
    t.integer  "host_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "curtain_time"
    t.date     "curtain_date"
    t.integer  "location_id"
    t.string   "invitee_salt"
    t.boolean  "bring_drinks"
    t.boolean  "bring_snacks"
    t.text     "notes"
    t.integer  "movie_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "voteable_movies", :force => true do |t|
    t.integer  "night_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "invitee_id"
    t.integer  "votable_movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
