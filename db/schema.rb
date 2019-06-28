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

ActiveRecord::Schema.define(version: 2018_03_04_195428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.string "name"
    t.text "description"
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_assignments_on_course_id"
  end

  create_table "contributions", id: :serial, force: :cascade do |t|
    t.integer "membership_id"
    t.integer "submission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["membership_id"], name: "index_contributions_on_membership_id"
    t.index ["submission_id"], name: "index_contributions_on_submission_id"
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "enrollment_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_code"], name: "index_courses_on_enrollment_code", unique: true
  end

  create_table "identities", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "accesstoken"
    t.string "uid"
    t.string "name"
    t.string "email"
    t.string "nickname"
    t.string "image"
    t.string "phone"
    t.string "urls"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "refreshtoken"
    t.string "secrettoken"
    t.index "lower((email)::text)", name: "index_identities_on_lower_email"
    t.index "lower((name)::text)", name: "index_identities_on_lower_name"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_memberships_on_course_id"
    t.index ["user_id", "course_id"], name: "index_memberships_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "memberships_teams", id: false, force: :cascade do |t|
    t.integer "membership_id"
    t.integer "team_id"
    t.index ["membership_id"], name: "index_memberships_teams_on_membership_id"
    t.index ["team_id"], name: "index_memberships_teams_on_team_id"
  end

  create_table "submissions", id: :serial, force: :cascade do |t|
    t.integer "status"
    t.integer "uploaded_by_id"
    t.integer "assignment_id"
    t.string "type"
    t.string "git_repository_url"
    t.string "git_commit_sha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "git_commit_message"
    t.string "github_repository_name"
    t.integer "team_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.bigint "file_file_size"
    t.datetime "file_updated_at"
    t.string "file_fingerprint"
    t.string "language"
    t.integer "test_results_count", default: 0
    t.integer "successful_test_results_count"
    t.index ["assignment_id"], name: "index_submissions_on_assignment_id"
    t.index ["team_id"], name: "index_submissions_on_team_id"
    t.index ["uploaded_by_id"], name: "index_submissions_on_uploaded_by_id"
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.integer "assignment_id"
    t.string "github_repository_name"
    t.integer "repository_owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_teams_on_assignment_id"
    t.index ["github_repository_name"], name: "index_teams_on_github_repository_name"
    t.index ["repository_owner_id"], name: "index_teams_on_repository_owner_id"
  end

  create_table "test_results", id: :serial, force: :cascade do |t|
    t.integer "test_id"
    t.integer "submission_id"
    t.integer "status"
    t.text "result_log"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "expected_program_output"
    t.text "program_input"
    t.boolean "public"
    t.string "filename"
    t.boolean "timeout", default: false
    t.text "error_log"
    t.float "execution_time"
    t.integer "exit_code"
    t.boolean "run_file_missing", default: false
    t.index ["submission_id"], name: "index_test_results_on_submission_id"
    t.index ["test_id"], name: "index_test_results_on_test_id"
  end

  create_table "tests", id: :serial, force: :cascade do |t|
    t.integer "assignment_id"
    t.string "name"
    t.text "description"
    t.string "type"
    t.text "program_input"
    t.text "expected_program_output"
    t.boolean "public"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "filename"
    t.index ["assignment_id"], name: "index_tests_on_assignment_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contributions", "memberships"
  add_foreign_key "contributions", "submissions"
  add_foreign_key "identities", "users"
  add_foreign_key "memberships", "courses"
  add_foreign_key "memberships", "users"
  add_foreign_key "memberships_teams", "memberships"
  add_foreign_key "memberships_teams", "teams"
  add_foreign_key "submissions", "assignments"
  add_foreign_key "submissions", "users", column: "uploaded_by_id"
  add_foreign_key "teams", "assignments"
  add_foreign_key "teams", "users", column: "repository_owner_id"
  add_foreign_key "test_results", "submissions"
  add_foreign_key "test_results", "tests"
  add_foreign_key "tests", "assignments"
end
