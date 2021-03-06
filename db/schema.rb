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

ActiveRecord::Schema.define(version: 2021_06_04_120323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "access_token"
    t.string "login"
    t.integer "git_id"
    t.text "avatar_url"
    t.text "url"
    t.text "repos_url"
    t.text "repositories"
    t.text "organisations_url"
    t.text "received_events_url"
    t.string "name"
    t.string "company"
    t.text "blog"
    t.string "location"
    t.string "email"
    t.text "bio"
    t.datetime "github_account_created_at"
    t.string "twitter_username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["login", "git_id", "email"], name: "index_users_on_login_and_git_id_and_email", unique: true
  end

end
