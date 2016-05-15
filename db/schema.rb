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

ActiveRecord::Schema.define(version: 20160514170923) do

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classrooms", force: :cascade do |t|
    t.integer  "school_class_id"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "classrooms", ["school_class_id"], name: "index_classrooms_on_school_class_id"

  create_table "school_administrations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "school_administrations", ["school_id"], name: "index_school_administrations_on_school_id"
  add_index "school_administrations", ["user_id"], name: "index_school_administrations_on_user_id"

  create_table "school_classes", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "school_classes", ["school_id"], name: "index_school_classes_on_school_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "active",     default: false
    t.integer  "user_id"
  end

  add_index "schools", ["user_id"], name: "index_schools_on_user_id"

  create_table "students", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "father_name"
    t.string   "mother_name"
    t.date     "birthdate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "students", ["school_id"], name: "index_students_on_school_id"

  create_table "studyings", force: :cascade do |t|
    t.integer  "classroom_id"
    t.integer  "student_id"
    t.date     "beginning_date"
    t.date     "end_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "studyings", ["classroom_id"], name: "index_studyings_on_classroom_id"
  add_index "studyings", ["student_id"], name: "index_studyings_on_student_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "school_class_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "subjects", ["school_class_id"], name: "index_subjects_on_school_class_id"

  create_table "teachings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "classroom_id"
    t.integer  "subject_id"
    t.boolean  "all_subjects"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "teachings", ["classroom_id"], name: "index_teachings_on_classroom_id"
  add_index "teachings", ["subject_id"], name: "index_teachings_on_subject_id"
  add_index "teachings", ["user_id"], name: "index_teachings_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
