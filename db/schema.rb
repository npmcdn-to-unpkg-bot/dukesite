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

ActiveRecord::Schema.define(version: 20160706171622) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "username",               limit: 255, default: "", null: false
    t.string   "first_name",             limit: 255, default: "", null: false
    t.string   "last_name",              limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree

  create_table "articles", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "subtitle",         limit: 255
    t.text     "content",          limit: 65535
    t.boolean  "published",                      default: false
    t.datetime "published_at"
    t.string   "slug",             limit: 255
    t.integer  "articleable_id",   limit: 4
    t.string   "articleable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carousels", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "url",         limit: 255
    t.string   "slug",        limit: 255
    t.boolean  "visible",                   default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "slug",       limit: 255
    t.boolean  "visible",                default: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "value",            limit: 255
    t.integer  "keywordable_id",   limit: 4
    t.string   "keywordable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",             limit: 255
  end

  create_table "newsletters", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.text     "content",    limit: 65535
    t.boolean  "sent",                     default: false
    t.datetime "sent_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "imageable_id",   limit: 4
    t.string   "imageable_type", limit: 255
    t.string   "image",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "category_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "product_categories", ["category_id"], name: "index_product_categories_on_category_id", using: :btree
  add_index "product_categories", ["product_id"], name: "index_product_categories_on_product_id", using: :btree

  create_table "product_showcases", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "showcase_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "product_showcases", ["product_id"], name: "index_product_showcases_on_product_id", using: :btree
  add_index "product_showcases", ["showcase_id"], name: "index_product_showcases_on_showcase_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.text     "url",             limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "published",                     default: false
    t.text     "image_url",       limit: 65535
    t.string   "slug",            limit: 255
    t.string   "asin",            limit: 255
    t.string   "image_url_small", limit: 255
  end

  create_table "quotes", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.boolean  "visible",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255
  end

  create_table "showcases", force: :cascade do |t|
    t.string   "title",                limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "show_on_landing_page",             default: false
    t.string   "slug",                 limit: 255
    t.boolean  "visible",                          default: false
    t.string   "subtitle",             limit: 255
  end

  create_table "site_configs", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.text     "value",      limit: 65535
    t.string   "slug",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "note",       limit: 255
    t.integer  "maxlength",  limit: 4
  end

  create_table "social_network_accounts", force: :cascade do |t|
    t.string   "platform_name", limit: 255
    t.text     "platform_url",  limit: 65535
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "visible",                     default: false
    t.string   "slug",          limit: 255
  end

  create_table "subscribers", force: :cascade do |t|
    t.string   "email",         limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "confirm_token", limit: 255
    t.boolean  "confirmed",                 default: false
  end

end
