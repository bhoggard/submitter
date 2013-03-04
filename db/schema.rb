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

ActiveRecord::Schema.define(:version => 20120209213033) do

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "works", :force => true do |t|
    t.string   "first_name",                            :null => false
    t.string   "last_name",                             :null => false
    t.string   "email",                                 :null => false
    t.string   "phone",                                 :null => false
    t.string   "committee_member",                      :null => false
    t.string   "title",                                 :null => false
    t.string   "year",                                  :null => false
    t.string   "materials",                             :null => false
    t.integer  "height",                                :null => false
    t.integer  "width",                                 :null => false
    t.integer  "length"
    t.string   "edition"
    t.integer  "estimated_value"
    t.string   "courtesy"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "confirmed",          :default => false, :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "website"
  end

  add_index "works", ["confirmed"], :name => "index_works_on_confirmed"
  add_index "works", ["last_name", "first_name"], :name => "index_works_on_last_name_and_first_name"

end
