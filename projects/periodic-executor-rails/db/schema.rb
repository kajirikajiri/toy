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

ActiveRecord::Schema[8.0].define(version: 2025_05_03_060527) do
  create_table "actions", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pattern", null: false
    t.string "executable_type", null: false
    t.string "executable_id", null: false
    t.datetime "completed_at"
    t.integer "status", default: 0, null: false
    t.integer "result"
    t.integer "browser_extension_result"
  end

  create_table "slack_messages", id: :string, force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "channel", null: false
    t.string "ts"
    t.string "text"
    t.text "response"
    t.string "thread_ts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", id: :string, force: :cascade do |t|
    t.string "url", null: false
    t.integer "episode_count"
    t.string "title", null: false
    t.integer "season", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "season"], name: "index_videos_on_title_and_season", unique: true
    t.index ["url"], name: "index_videos_on_url", unique: true
  end

  create_table "watch_lists", id: :string, force: :cascade do |t|
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
