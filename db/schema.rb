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

ActiveRecord::Schema.define(version: 20170316021022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "ratings", force: :cascade do |t|
    t.boolean  "recommend"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "morphic_rating_type"
    t.integer  "morphic_rating_id"
    t.index ["morphic_rating_type", "morphic_rating_id"], name: "index_ratings_on_morphic_rating_type_and_morphic_rating_id", using: :btree
  end

  create_table "resource_types", force: :cascade do |t|
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "subject_id"
    t.string   "medium"
    t.string   "author"
    t.string   "isbn"
    t.string   "organization"
    t.string   "url"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.boolean  "free"
    t.integer  "resource_type_id"
    t.index ["resource_type_id"], name: "index_resources_on_resource_type_id", using: :btree
    t.index ["subject_id"], name: "index_resources_on_subject_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "resource_id"
    t.index ["resource_id"], name: "index_reviews_on_resource_id", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_subjects_on_parent_id", using: :btree
  end

end
