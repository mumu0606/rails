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

ActiveRecord::Schema.define(version: 20150721032222) do

  create_table "data", force: :cascade do |t|
    t.integer  "pokemon_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "poke_id",    limit: 4
    t.integer  "p1",         limit: 4
    t.integer  "p2",         limit: 4
    t.integer  "p3",         limit: 4
    t.integer  "p4",         limit: 4
    t.integer  "p5",         limit: 4
    t.integer  "m1",         limit: 4
    t.integer  "m2",         limit: 4
    t.integer  "m3",         limit: 4
    t.integer  "m4",         limit: 4
  end

  create_table "items", force: :cascade do |t|
    t.integer  "item_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "move_items", force: :cascade do |t|
    t.integer  "move_id",    limit: 4
    t.integer  "item_id",    limit: 4
    t.integer  "cooccur",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "move_items", ["item_id"], name: "index_move_items_on_item_id", using: :btree
  add_index "move_items", ["move_id"], name: "index_move_items_on_move_id", using: :btree

  create_table "moves", force: :cascade do |t|
    t.integer  "move_id",    limit: 4,   null: false
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "moves", ["move_id"], name: "index_moves_on_move_id", unique: true, using: :btree

  create_table "pokemon_data", force: :cascade do |t|
    t.integer  "pokemon_id", limit: 4
    t.integer  "item",       limit: 4
    t.integer  "poke1",      limit: 4
    t.integer  "poke2",      limit: 4
    t.integer  "poke3",      limit: 4
    t.integer  "poke4",      limit: 4
    t.integer  "move1",      limit: 4
    t.integer  "move2",      limit: 4
    t.integer  "move3",      limit: 4
    t.integer  "move4",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "pokemon_infos", force: :cascade do |t|
    t.integer  "pokemon_id", limit: 4
    t.integer  "item",       limit: 4
    t.integer  "partner1",   limit: 4
    t.integer  "partner2",   limit: 4
    t.integer  "partner3",   limit: 4
    t.integer  "partner4",   limit: 4
    t.integer  "move1",      limit: 4
    t.integer  "move2",      limit: 4
    t.integer  "move3",      limit: 4
    t.integer  "move4",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "partner5",   limit: 4
  end

  create_table "pokemons", force: :cascade do |t|
    t.integer  "poke_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "image",      limit: 65535
  end

  add_index "pokemons", ["name"], name: "index_pokemons_on_name", using: :btree
  add_index "pokemons", ["poke_id"], name: "index_pokemons_on_poke_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "username",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "move_items", "moves", primary_key: "move_id"
end
