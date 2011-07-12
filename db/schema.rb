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

ActiveRecord::Schema.define(:version => 20110710184340) do

  create_table "events", :force => true do |t|
    t.integer  "eibf_id"
    t.string   "title"
    t.string   "sub_title"
    t.string   "standfirst"
    t.datetime "start_time"
    t.date     "date"
    t.boolean  "is_sold_out"
    t.string   "event_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_sponsors"
    t.integer  "duration"
    t.string   "venue"
    t.text     "description"
    t.string   "price"
    t.string   "image"
    t.string   "theme"
    t.string   "main_site_url"
  end

end
