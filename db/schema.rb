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

ActiveRecord::Schema.define(:version => 20201022225426) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "age"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "clients", ["email"], :name => "index_clients_on_email", :unique => true

  create_table "room_types", :force => true do |t|
    t.string   "room"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "view_types", :force => true do |t|
    t.string   "view"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "view_types", ["view"], :name => "index_view_types_on_view", :unique => true

end
