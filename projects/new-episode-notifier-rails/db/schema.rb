# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_11_020049) do
  create_table "scrapes", id: :string, force: :cascade do |t|
    t.date "executed_at"
    t.text "raw_dom"
    t.string "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["video_id"], name: "index_scrapes_on_video_id"
  end

  create_table "videos", id: :string, force: :cascade do |t|
    t.string "url", null: false
    t.integer "episode_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_videos_on_url", unique: true
  end

  add_foreign_key "scrapes", "videos"
end
