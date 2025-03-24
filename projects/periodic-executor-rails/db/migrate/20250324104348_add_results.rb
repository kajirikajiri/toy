class AddResults < ActiveRecord::Migration[8.0]
  def change
    create_table :results, id: :string do |t|
      t.references :action, null: false, foreign_key: true
      t.integer :browser_extension_result, null: false, comment: "ブラウザ拡張機能の実行結果"
      t.integer :action_result, null: false, comment: "アクションの実行結果"

      t.timestamps
    end
  end
end
