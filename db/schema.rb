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

ActiveRecord::Schema.define(version: 20150630023900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.integer "resident_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.integer "resident_id"
    t.date    "date"
    t.integer "chair_stand"
    t.integer "arm_curl"
    t.integer "two_minute_step"
    t.decimal "sit_and_reach"
    t.decimal "back_scratch"
    t.decimal "eight_foot_up_and_go"
    t.integer "chair_stand_percentile"
    t.integer "arm_curl_percentile"
    t.integer "two_minute_step_percentile"
    t.integer "sit_and_reach_percentile"
    t.integer "back_scratch_percentile"
    t.integer "eight_foot_up_and_go_percentile"
  end

  add_index "assessments", ["resident_id"], name: "index_assessments_on_resident_id", using: :btree

  create_table "assessors", force: :cascade do |t|
    t.integer "resident_id"
  end

  create_table "assessors_communities", id: false, force: :cascade do |t|
    t.integer "community_id"
    t.integer "assessor_id"
  end

  add_index "assessors_communities", ["assessor_id"], name: "index_assessors_communities_on_assessor_id", using: :btree
  add_index "assessors_communities", ["community_id"], name: "index_assessors_communities_on_community_id", using: :btree

  create_table "communities", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
  end

  create_table "norms", force: :cascade do |t|
    t.string  "test"
    t.string  "gender"
    t.integer "min_age"
    t.integer "max_age"
    t.decimal "scores",  array: true
  end

  create_table "residents", force: :cascade do |t|
    t.integer "community_id"
    t.date    "birthdate"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "gender"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "phone"
  end

  add_index "residents", ["community_id"], name: "index_residents_on_community_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "person_id"
    t.string   "person_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["person_type", "person_id"], name: "index_users_on_person_type_and_person_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
