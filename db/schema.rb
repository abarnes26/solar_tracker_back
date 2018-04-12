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
    t.float "size_kW"
    t.integer "number_of_pv_modules"
    t.float "local_annual_irradiance"
    t.float "local_carbon_g_per_kWh"
    t.float "system_carbon_g_per_kWh"
    t.float "total_system_carbon_impact_g"
    t.float "annual_production_kWh"
    t.integer "age_days", default: 1
    t.float "round_trip_miles"
    t.string "status", default: "active"
    t.bigint "branch_id"
    t.bigint "pv_module_id"
    t.index ["branch_id"], name: "index_projects_on_branch_id"
    t.index ["pv_module_id"], name: "index_projects_on_pv_module_id"
  end

  create_table "pv_modules", force: :cascade do |t|
    t.integer "output_w"
    t.float "efficiency"
    t.string "manufacturer"
    t.string "model"
    t.integer "width_mm"
    t.integer "length_mm"
    t.bigint "branch_id"
    t.index ["branch_id"], name: "index_pv_modules_on_branch_id"
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
    t.bigint "branch_id"
    t.index ["branch_id"], name: "index_vehicles_on_branch_id"
  end

  add_foreign_key "branch_users", "branches"
  add_foreign_key "branch_users", "users"
  add_foreign_key "project_vehicles", "projects"
  add_foreign_key "project_vehicles", "vehicles"
  add_foreign_key "projects", "branches"
  add_foreign_key "projects", "pv_modules"
  add_foreign_key "pv_modules", "branches"
  add_foreign_key "vehicles", "branches"
end
