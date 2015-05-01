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

ActiveRecord::Schema.define(version: 20150501075846) do

  create_table "data", force: :cascade do |t|
    t.integer  "pokemon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "poke_id"
    t.integer  "p1"
    t.integer  "p2"
    t.integer  "p3"
    t.integer  "p4"
    t.integer  "p5"
    t.integer  "m1"
    t.integer  "m2"
    t.integer  "m3"
    t.integer  "m4"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "move_items", force: :cascade do |t|
    t.integer  "move_id"
    t.integer  "item_id"
    t.integer  "cooccur"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "move_items", ["item_id"], name: "index_move_items_on_item_id"
  add_index "move_items", ["move_id"], name: "index_move_items_on_move_id"

  create_table "moves", force: :cascade do |t|
    t.string   "move_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "moves", ["move_id"], name: "index_moves_on_move_id", unique: true

  create_table "pokemons", force: :cascade do |t|
    t.integer  "poke_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "image"
  end

  add_index "pokemons", ["name"], name: "index_pokemons_on_name"
  add_index "pokemons", ["poke_id"], name: "index_pokemons_on_poke_id"

end
