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

ActiveRecord::Schema.define(version: 20180520134932) do

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "shortname"
  end

  create_table "periods", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "section_id"
    t.integer  "course_id"
    t.integer  "period_no"
    t.boolean  "incharge",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "no_of_days"
    t.index ["course_id"], name: "index_periods_on_course_id"
    t.index ["section_id"], name: "index_periods_on_section_id"
    t.index ["teacher_id"], name: "index_periods_on_teacher_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "statment"
    t.integer  "question_type"
    t.integer  "course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "image"
    t.index ["course_id"], name: "index_questions_on_course_id"
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "name"
    t.integer  "grade"
    t.date     "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "father_name"
    t.date     "dob"
    t.string   "father_cnic"
    t.string   "mobile"
    t.integer  "section_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["section_id"], name: "index_students_on_section_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.string   "father_name"
    t.string   "designation"
    t.integer  "bps"
    t.string   "qualification"
    t.date     "dob"
    t.date     "date_of_appointment"
    t.date     "date_of_present_grade"
    t.date     "date_of_joining_school"
    t.string   "cnic"
    t.text     "address"
    t.string   "mobile"
    t.integer  "school",                 default: 0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image"
  end

end
