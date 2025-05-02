class CreateWatchLists < ActiveRecord::Migration[8.0]
  def change
    create_table :watch_lists, id: :string do |t|
      t.string :url, null: false
      t.timestamps
    end
  end
end
