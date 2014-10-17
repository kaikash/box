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

ActiveRecord::Schema.define(version: 20141014121306) do

  create_table "lines", force: true do |t|
    t.text     "name"
    t.string   "img"
    t.float    "order_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines_storages", id: false, force: true do |t|
    t.integer "line_id"
    t.integer "storage_id"
  end

  add_index "lines_storages", ["line_id"], name: "index_lines_storages_on_line_id"
  add_index "lines_storages", ["storage_id"], name: "index_lines_storages_on_storage_id"

  create_table "providers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storages", force: true do |t|
    t.integer  "provider_id"
    t.text     "post_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "storages", ["provider_id"], name: "index_storages_on_provider_id"

end
