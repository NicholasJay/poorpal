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

ActiveRecord::Schema.define(version: 20140213190904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: true do |t|
    t.string  "name"
    t.integer "price"
    t.string  "store"
    t.integer "shopping_list_id"
  end

  create_table "shopping_lists", force: true do |t|
    t.string  "title"
    t.date    "date"
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.string  "phone_number"
    t.string  "street_address"
    t.string  "city"
    t.string  "state"
    t.integer "zipcode"
    t.string  "password_digest"
  end

end
