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

ActiveRecord::Schema.define(version: 20140328191148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",       limit: 100, null: false
    t.integer  "parent_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree
  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "category_subscriptions", force: true do |t|
    t.integer  "subscriber_id", null: false
    t.integer  "category_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_subscriptions", ["category_id"], name: "index_category_subscriptions_on_category_id", using: :btree
  add_index "category_subscriptions", ["subscriber_id", "category_id"], name: "index_category_subscriptions_on_subscriber_id_and_category_id", unique: true, using: :btree

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "resource_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["resource_id"], name: "index_comments_on_resource_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "resource_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["resource_id"], name: "index_favorites_on_resource_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "resource_types", force: true do |t|
    t.string   "name",       limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", force: true do |t|
    t.string   "title",            limit: 150,                  null: false
    t.string   "domain",           limit: 75,                   null: false
    t.string   "path",                         default: "/",    null: false
    t.string   "query_string"
    t.integer  "port",                         default: 80,     null: false
    t.string   "protocol",         limit: 10,  default: "http", null: false
    t.text     "description"
    t.integer  "user_id",                                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "category_id"
    t.integer  "up_votes_count",               default: 0,      null: false
    t.integer  "down_votes_count",             default: 0,      null: false
    t.integer  "resource_type_id"
  end

  add_index "resources", ["created_at"], name: "index_resources_on_created_at", using: :btree
  add_index "resources", ["domain", "path", "query_string"], name: "index_resources_on_domain_and_path_and_query_string", unique: true, using: :btree
  add_index "resources", ["down_votes_count"], name: "index_resources_on_down_votes_count", using: :btree
  add_index "resources", ["resource_type_id"], name: "index_resources_on_resource_type_id", using: :btree
  add_index "resources", ["slug"], name: "index_resources_on_slug", unique: true, using: :btree
  add_index "resources", ["up_votes_count"], name: "index_resources_on_up_votes_count", using: :btree
  add_index "resources", ["user_id"], name: "index_resources_on_user_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "token",      limit: 24, null: false
    t.integer  "user_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["token"], name: "index_sessions_on_token", unique: true, using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        limit: 50,                  null: false
    t.string   "email",           limit: 100,                 null: false
    t.string   "password_digest", limit: 60
    t.datetime "last_sign_in"
    t.boolean  "admin",                       default: false, null: false
    t.boolean  "blocked",                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "resource_id", null: false
    t.integer  "direction",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["resource_id", "user_id"], name: "index_votes_on_resource_id_and_user_id", unique: true, using: :btree
  add_index "votes", ["resource_id"], name: "index_votes_on_resource_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
