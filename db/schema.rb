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

ActiveRecord::Schema.define(:version => 20100921153623) do

  create_table "address_types", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.integer  "address_type_id"
    t.string   "street",          :limit => 250
    t.string   "city",            :limit => 100
    t.string   "state",           :limit => 100
    t.string   "zip_code",        :limit => 15
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses_contacts", :id => false, :force => true do |t|
    t.integer "address_id"
    t.integer "contact_id"
  end

  create_table "contacts", :force => true do |t|
    t.string   "title",      :limit => 5
    t.string   "first_name", :limit => 50
    t.string   "middle",     :limit => 50
    t.string   "last_name",  :limit => 50
    t.string   "suffix",     :limit => 15
    t.string   "job_title",  :limit => 100
    t.string   "company",    :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts_internet_infos", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "internet_info_id"
  end

  create_table "contacts_phone_numbers", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "phone_number_id"
  end

  create_table "internet_info_types", :force => true do |t|
    t.string   "description", :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internet_infos", :force => true do |t|
    t.integer  "internet_info_type_id"
    t.string   "description",           :limit => 150
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_number_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_numbers", :force => true do |t|
    t.integer "phone_number_type_id"
    t.string  "phone_number"
  end

  create_table "users", :force => true do |t|
    t.string   "firstname",  :limit => 50
    t.string   "lastname",   :limit => 50
    t.string   "username",   :limit => 25
    t.string   "password",   :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
