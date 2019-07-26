# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_25_230445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.text "key", null: false
    t.text "menu_text", null: false
    t.text "name", null: false
    t.text "description", null: false
    t.text "repo_name"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.text "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "gh_url"
    t.string "gh_description"
    t.datetime "gh_created_at"
    t.datetime "gh_last_pushed_at"
    t.datetime "gh_last_updated_at"
    t.string "gh_clone_url"
    t.string "gh_homepage"
    t.integer "gh_size"
    t.string "gh_license"
    t.string "gh_languages"
    t.index ["key"], name: "index_projects_on_key"
  end

end
