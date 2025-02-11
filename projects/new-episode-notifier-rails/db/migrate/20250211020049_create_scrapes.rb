class CreateScrapes < ActiveRecord::Migration[8.0]
  def change
    create_table :scrapes, id: :string do |t|
      # scheduled_atは構成上当てにならないのでexecuteed_atを使う
      t.date :executed_at, comment: "実行した時間"
      t.text :raw_dom, null: true, comment: "HTML DOM"
      t.references :video, type: :string, null: false, foreign_key: true
      t.timestamps
    end
  end
end
