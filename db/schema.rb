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

ActiveRecord::Schema.define(version: 20150303102800) do

  create_table "account_activities", force: true do |t|
    t.integer  "account_id"
    t.string   "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_activities", ["account_id"], name: "index_account_activities_on_account_id", using: :btree
  add_index "account_activities", ["activity_id"], name: "index_account_activities_on_activity_id", using: :btree

  create_table "account_fitnesses", force: true do |t|
    t.integer  "account_id"
    t.integer  "steps"
    t.integer  "calories"
    t.integer  "weight"
    t.integer  "distance"
    t.integer  "speed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_fitnesses", ["account_id"], name: "index_account_fitnesses_on_account_id", using: :btree

  create_table "account_goals", force: true do |t|
    t.integer  "account_id"
    t.integer  "goal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_goals", ["account_id"], name: "index_account_goals_on_account_id", using: :btree
  add_index "account_goals", ["goal_id"], name: "index_account_goals_on_goal_id", using: :btree

  create_table "account_gyms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "address"
    t.string   "specialties"
    t.integer  "franchise"
    t.string   "groupclasses"
    t.string   "dancetypes"
    t.integer  "train_client_at_your_gym"
    t.float    "fee",                      limit: 24
    t.string   "amenities"
    t.string   "timings",                  limit: 555
  end

  create_table "account_privacies", force: true do |t|
    t.integer  "account_id"
    t.boolean  "profile_pic"
    t.boolean  "email"
    t.boolean  "mobile"
    t.boolean  "birthday"
    t.boolean  "work"
    t.boolean  "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bio",         limit: 1
  end

  add_index "account_privacies", ["account_id"], name: "index_account_privacies_on_account_id", using: :btree

  create_table "account_pros", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_trainers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gym_id"
    t.string   "fitness_discpline"
    t.string   "certs"
    t.string   "awards"
    t.string   "personal_training"
    t.integer  "age"
    t.string   "bootcamp"
    t.string   "location_bootcamp"
    t.string   "group_training"
    t.string   "affiliate"
    t.string   "url"
    t.string   "train_user_type"
    t.string   "home_training"
    t.integer  "account_id"
    t.string   "workout_tips"
    t.string   "certificates"
  end

  create_table "account_users", force: true do |t|
    t.integer  "account_id"
    t.string   "account_url",        limit: 30
    t.integer  "account_trainer_id"
    t.integer  "account_pro_id"
    t.boolean  "gym_enrollment"
    t.integer  "gym_id"
    t.integer  "title_id"
    t.boolean  "gender"
    t.integer  "relationship_id"
    t.integer  "birthday"
    t.string   "address"
    t.integer  "industry_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trainer_contacts"
  end

  create_table "accounts", force: true do |t|
    t.string   "fit_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "account_url"
    t.string   "user_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "mobile"
    t.integer  "status",              limit: 1, default: 1
    t.string   "email"
    t.integer  "city_id"
    t.string   "state_id",            limit: 4
    t.integer  "country_id"
    t.integer  "age"
    t.string   "gender"
    t.integer  "gym_id"
    t.integer  "gym_location_id"
    t.integer  "industry_id"
    t.integer  "profession_id"
    t.integer  "relationship_id"
    t.string   "goals"
    t.integer  "reason_id"
    t.date     "dob"
    t.string   "company"
    t.string   "zipcode"
    t.string   "fb_link"
    t.string   "tw_link"
    t.string   "google_link"
    t.string   "linked_link"
    t.integer  "belong",              limit: 1
    t.string   "remember_token"
    t.string   "pic"
    t.integer  "user_type",           limit: 1, default: 1
  end

  add_index "accounts", ["id"], name: "index_accounts_on_id", using: :btree

  create_table "activities", force: true do |t|
    t.string   "name",       limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
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
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "album_images", force: true do |t|
    t.integer  "album_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "albums", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "share_with"
    t.integer  "account_id"
  end

  create_table "amenities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name",       limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.integer  "state_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state_code", limit: 4
  end

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.integer  "account_id"
    t.text     "text"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name",       limit: 55
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "account_id"
    t.integer  "friend_id"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seen",       default: 0
  end

  create_table "goals", force: true do |t|
    t.string   "name",       limit: 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gyms", force: true do |t|
    t.string   "name",           limit: 55
    t.integer  "account_gym_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "name",       limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "account_id"
    t.text     "text"
    t.string   "share_with"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image"
    t.string   "video"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

  create_table "privacies", force: true do |t|
    t.string   "name",       limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "professions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reasons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.string   "name",       limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specialties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.integer  "country_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state_code", limit: 4
  end

  create_table "titles", force: true do |t|
    t.string   "name",       limit: 55
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zipcodes", force: true do |t|
    t.integer  "city_id"
    t.string   "zipcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
