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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131005221214) do

  create_table "bookings", :force => true do |t|
    t.string   "ref",              :null => false
    t.string   "room_ref"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "number_of_guests"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["ref"], :name => "index_bookings_on_ref", :unique => true
  add_index "bookings", ["room_ref"], :name => "room_ref"

  create_table "hosts", :force => true do |t|
    t.string   "ref",        :null => false
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hosts", ["ref"], :name => "index_hosts_on_ref", :unique => true

  create_table "rooms", :force => true do |t|
    t.string   "ref",        :null => false
    t.string   "host_ref"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rooms", ["host_ref"], :name => "host_ref"
  add_index "rooms", ["ref"], :name => "index_rooms_on_ref", :unique => true

end
