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

ActiveRecord::Schema.define(:version => 20201025064539) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "clients", ["email"], :name => "index_clients_on_email", :unique => true
  add_index "clients", ["remember_token"], :name => "index_clients_on_remember_token"

  create_table "price_modifiers", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reservation_dates", :force => true do |t|
    t.date     "date"
    t.boolean  "weekend"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "price_modifier_id"
  end

  add_index "reservation_dates", ["date"], :name => "index_reservation_dates_on_date", :unique => true
  add_index "reservation_dates", ["price_modifier_id"], :name => "index_reservation_dates_on_price_modifier_id"

  create_table "reservations", :force => true do |t|
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "demands"
  end

  add_index "reservations", ["client_id"], :name => "index_reservations_on_client_id"

  create_table "room_reservations", :force => true do |t|
    t.integer  "reservation_date_id"
    t.integer  "room_id"
    t.decimal  "price"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "reservation_id"
  end

  add_index "room_reservations", ["reservation_date_id"], :name => "index_room_reservations_on_date_id"
  add_index "room_reservations", ["reservation_id"], :name => "index_room_reservations_on_reservation_id"
  add_index "room_reservations", ["room_id"], :name => "index_room_reservations_on_room_id"

  create_table "room_types", :force => true do |t|
    t.string   "room"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.decimal  "price"
  end

  add_index "room_types", ["room"], :name => "index_room_types_on_room", :unique => true

  create_table "rooms", :force => true do |t|
    t.integer  "room_num"
    t.boolean  "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.decimal  "price"
    t.integer  "room_type_id"
    t.integer  "view_type_id"
  end

  add_index "rooms", ["room_type_id"], :name => "index_rooms_on_room_type_id"
  add_index "rooms", ["view_type_id"], :name => "index_rooms_on_view_type_id"

  create_table "view_types", :force => true do |t|
    t.string   "view"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.decimal  "price"
  end

  add_index "view_types", ["view"], :name => "index_view_types_on_view", :unique => true

  create_table "weekend_prices", :force => true do |t|
    t.decimal  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
