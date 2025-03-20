class RemoveScrapes < ActiveRecord::Migration[8.0]
  def change
    drop_table :scrapes, id: :string, force: :cascade do |t|
      t.datetime "executed_at"
      t.string "video_id", null: false
      t.timestamps null: false
      t.index ["video_id"], name: "index_scrapes_on_video_id"
    end
  end
end
