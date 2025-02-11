class CreateVideos < ActiveRecord::Migration[8.0]
  def change
    create_table :videos, id: :string do |t|
      t.string :url, null: false, comment: "動画URL", index: { unique: true }
      t.integer :episode_count, comment: "エピソード数"
      t.timestamps
    end
  end
end
