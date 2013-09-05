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

ActiveRecord::Schema.define(version: 20130904221754) do

  create_table "meter_cat_meters", force: true do |t|
    t.string  "name",         limit: 64,             null: false
    t.date    "created_on"
    t.integer "value",                   default: 0
    t.integer "lock_version",            default: 0
  end

  add_index "meter_cat_meters", ["created_on", "name"], name: "index_meter_cat_meters_on_created_on_and_name", unique: true

end
