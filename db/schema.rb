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

ActiveRecord::Schema.define(version: 20160620011244) do

  create_table "activities", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "lesson_id"
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "activities", ["lesson_id"], name: "index_activities_on_lesson_id"
  add_index "activities", ["student_id"], name: "index_activities_on_student_id"

  create_table "classrooms", force: :cascade do |t|
    t.integer  "school_class_id"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "classrooms", ["school_class_id"], name: "index_classrooms_on_school_class_id"

  create_table "days", force: :cascade do |t|
    t.integer  "classroom_id"
    t.date     "date"
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "exams", force: :cascade do |t|
    t.integer  "classroom_id"
    t.integer  "subject_id"
    t.integer  "score"
    t.integer  "minimum_score"
    t.date     "date"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "exams", ["classroom_id"], name: "index_exams_on_classroom_id"
  add_index "exams", ["subject_id"], name: "index_exams_on_subject_id"

  create_table "following_codes", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "code"
    t.datetime "expire_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "following_codes", ["code"], name: "index_following_codes_on_code"
  add_index "following_codes", ["student_id"], name: "index_following_codes_on_student_id"

  create_table "followings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "student_id"
    t.string   "relationship"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "followings", ["student_id"], name: "index_followings_on_student_id"
  add_index "followings", ["user_id"], name: "index_followings_on_user_id"

  create_table "grades", force: :cascade do |t|
    t.integer  "exam_id"
    t.integer  "student_id"
    t.decimal  "score",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "grades", ["exam_id"], name: "index_grades_on_exam_id"
  add_index "grades", ["student_id"], name: "index_grades_on_student_id"

  create_table "lessons", force: :cascade do |t|
    t.integer  "day_id"
    t.integer  "subject_id"
    t.integer  "order"
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "lessons", ["day_id"], name: "index_lessons_on_day_id"
  add_index "lessons", ["subject_id"], name: "index_lessons_on_subject_id"

  create_table "periods", force: :cascade do |t|
    t.integer  "timetable_id"
    t.integer  "subject_id"
    t.string   "day"
    t.integer  "order"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "periods", ["subject_id"], name: "index_periods_on_subject_id"
  add_index "periods", ["timetable_id"], name: "index_periods_on_timetable_id"

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
    t.text     "description"
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

  create_table "timetables", force: :cascade do |t|
    t.integer  "classroom_id"
    t.boolean  "active"
    t.text     "weekends"
    t.integer  "periods_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "timetables", ["classroom_id"], name: "index_timetables_on_classroom_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "failed_attempts",                   default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token",   limit: 30
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
