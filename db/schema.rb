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

ActiveRecord::Schema.define(version: 20180404202710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branch_users", force: :cascade do |t|
    t.bigint "branch_id"
    t.bigint "user_id"
    t.index ["branch_id"], name: "index_branch_users_on_branch_id"
    t.index ["user_id"], name: "index_branch_users_on_user_id"
  end

  create_table "branch_vehicles", force: :cascade do |t|
    t.bigint "branch_id"
    t.bigint "vehicle_id"
    t.index ["branch_id"], name: "index_branch_vehicles_on_branch_id"
    t.index ["vehicle_id"], name: "index_branch_vehicles_on_vehicle_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
  end

  create_table "project_vehicles", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "vehicle_id"
    t.index ["project_id"], name: "index_project_vehicles_on_project_id"
    t.index ["vehicle_id"], name: "index_project_vehicles_on_vehicle_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "customer_name"
    t.integer "size_kW"
    t.string "solar_data"
    t.integer "carbon_impact_lbs"
    t.integer "annual_offset"
    t.integer "age_days"
    t.integer "round_trip_miles"
    t.string "status"
    t.bigint "branch_id"
    t.index ["branch_id"], name: "index_projects_on_branch_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "company"
    t.string "email"
    t.string "password_digest"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "mpg"
  end

  add_foreign_key "branch_users", "branches"
  add_foreign_key "branch_users", "users"
  add_foreign_key "branch_vehicles", "branches"
  add_foreign_key "branch_vehicles", "vehicles"
  add_foreign_key "project_vehicles", "projects"
  add_foreign_key "project_vehicles", "vehicles"
  add_foreign_key "projects", "branches"
end
