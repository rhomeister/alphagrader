# frozen_string_literal: true
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

ActiveRecord::Schema.define(version: 20_170_106_003_653) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_admin_comments', force: :cascade do |t|
    t.string   'namespace'
    t.text     'body'
    t.string   'resource_id',   null: false
    t.string   'resource_type', null: false
    t.string   'author_type'
    t.integer  'author_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w(author_type author_id), name: 'index_active_admin_comments_on_author_type_and_author_id', using: :btree
    t.index ['namespace'], name: 'index_active_admin_comments_on_namespace', using: :btree
    t.index %w(resource_type resource_id), name: 'index_active_admin_comments_on_resource_type_and_resource_id', using: :btree
  end

  create_table 'assignments', force: :cascade do |t|
    t.integer  'course_id'
    t.string   'name'
    t.text     'description'
    t.datetime 'due_date'
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.index ['course_id'], name: 'index_assignments_on_course_id', using: :btree
  end

  create_table 'author_submissions', id: false, force: :cascade do |t|
    t.integer 'author_id'
    t.integer 'submission_id'
    t.index ['author_id'], name: 'index_author_submissions_on_author_id', using: :btree
    t.index ['submission_id'], name: 'index_author_submissions_on_submission_id', using: :btree
  end

  create_table 'courses', force: :cascade do |t|
    t.string   'name'
    t.text     'description'
    t.string   'enrollment_code'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
    t.index ['enrollment_code'], name: 'index_courses_on_enrollment_code', unique: true, using: :btree
  end

  create_table 'identities', force: :cascade do |t|
    t.integer  'user_id'
    t.string   'provider'
    t.string   'accesstoken'
    t.string   'uid'
    t.string   'name'
    t.string   'email'
    t.string   'nickname'
    t.string   'image'
    t.string   'phone'
    t.string   'urls'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
    t.string   'refreshtoken'
    t.string   'secrettoken'
    t.index ['user_id'], name: 'index_identities_on_user_id', using: :btree
  end

  create_table 'memberships', force: :cascade do |t|
    t.integer  'user_id'
    t.integer  'course_id'
    t.integer  'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['course_id'], name: 'index_memberships_on_course_id', using: :btree
    t.index %w(user_id course_id), name: 'index_memberships_on_user_id_and_course_id', unique: true, using: :btree
    t.index ['user_id'], name: 'index_memberships_on_user_id', using: :btree
  end

  create_table 'submissions', force: :cascade do |t|
    t.integer  'status'
    t.integer  'uploaded_by_id'
    t.integer  'assignment_id'
    t.string   'type'
    t.string   'git_repository_url'
    t.string   'git_commit_sha'
    t.datetime 'created_at',             null: false
    t.datetime 'updated_at',             null: false
    t.string   'git_commit_message'
    t.string   'github_repository_name'
    t.index ['assignment_id'], name: 'index_submissions_on_assignment_id', using: :btree
    t.index ['uploaded_by_id'], name: 'index_submissions_on_uploaded_by_id', using: :btree
  end

  create_table 'test_results', force: :cascade do |t|
    t.integer  'test_id'
    t.integer  'submission_id'
    t.integer  'status'
    t.text     'result_log'
    t.string   'type'
    t.datetime 'created_at',              null: false
    t.datetime 'updated_at',              null: false
    t.string   'name'
    t.text     'expected_program_output'
    t.text     'program_input'
    t.boolean  'public'
    t.index ['submission_id'], name: 'index_test_results_on_submission_id', using: :btree
    t.index ['test_id'], name: 'index_test_results_on_test_id', using: :btree
  end

  create_table 'tests', force: :cascade do |t|
    t.integer  'assignment_id'
    t.string   'name'
    t.text     'description'
    t.string   'type'
    t.text     'program_input'
    t.text     'expected_program_output'
    t.boolean  'public'
    t.datetime 'created_at',              null: false
    t.datetime 'updated_at',              null: false
    t.index ['assignment_id'], name: 'index_tests_on_assignment_id', using: :btree
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email',                  default: ''
    t.string   'encrypted_password',     default: '', null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string   'current_sign_in_ip'
    t.string   'last_sign_in_ip'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
    t.integer  'role'
    t.string   'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string   'unconfirmed_email'
    t.string   'name'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true, using: :btree
    t.index ['email'], name: 'index_users_on_email', using: :btree
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
  end

  add_foreign_key 'author_submissions', 'submissions'
  add_foreign_key 'author_submissions', 'users', column: 'author_id'
  add_foreign_key 'identities', 'users'
  add_foreign_key 'memberships', 'courses'
  add_foreign_key 'memberships', 'users'
  add_foreign_key 'submissions', 'assignments'
  add_foreign_key 'submissions', 'users', column: 'uploaded_by_id'
  add_foreign_key 'test_results', 'submissions'
  add_foreign_key 'test_results', 'tests'
  add_foreign_key 'tests', 'assignments'
end
