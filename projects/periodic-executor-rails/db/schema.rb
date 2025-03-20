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

ActiveRecord::Schema[8.0].define(version: 2025_03_20_134914) do
  create_table "action_results", id: :string, force: :cascade do |t|
    t.boolean "success", default: false, null: false
    t.text "steps", null: false
    t.integer "action_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_id"], name: "index_action_results_on_action_id"
  end

  create_table "actions", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "pattern", default: 0, null: false
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

# Could not dump table "steps" because of following StandardError
#   Unknown type 'uuid' for column 'action_id'


  create_table "videos", id: :string, force: :cascade do |t|
    t.string "url", null: false
    t.integer "episode_count"
    t.string "title", null: false
    t.integer "season", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "season"], name: "index_videos_on_title_and_season", unique: true
    t.index ["url"], name: "index_videos_on_url", unique: true
  end

  add_foreign_key "action_results", "actions"
  add_foreign_key "steps", "actions"
end
