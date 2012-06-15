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

ActiveRecord::Schema.define(:version => 20110810071228) do

  create_table "appearances", :force => true do |t|
    t.integer  "event_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", :force => true do |t|
    t.integer  "eibf_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "books", :force => true do |t|
    t.integer  "eibf_id"
    t.string   "title"
    t.string   "amazon_url"
    t.string   "isbn"
    t.string   "amazon_image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stock_status"
  end

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
    t.datetime "end_time"
  end

  create_table "featured_books", :force => true do |t|
    t.integer  "event_id"
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "festival_themes", :force => true do |t|
    t.datetime "show_from"
    t.string   "high_file_name"
    t.string   "high_content_type"
    t.integer  "high_file_size"
    t.datetime "high_updated_at"
    t.string   "medium_file_name"
    t.string   "medium_content_type"
    t.integer  "medium_file_size"
    t.datetime "medium_updated_at"
    t.string   "low_file_name"
    t.string   "low_content_type"
    t.integer  "low_file_size"
    t.datetime "low_updated_at"
    t.string   "shortcut_file_name"
    t.string   "shortcut_content_type"
    t.integer  "shortcut_file_size"
    t.datetime "shortcut_updated_at"
    t.string   "splash_file_name"
    t.string   "splash_content_type"
    t.integer  "splash_file_size"
    t.datetime "splash_updated_at"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

end
