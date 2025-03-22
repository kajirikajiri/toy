class DropActionResults < ActiveRecord::Migration[8.0]
  def change
    drop_table :action_results, id: :string, force: :cascade do |t|
      t.string :id, null: false, primary_key: true
      t.boolean :success, null: false, default: false
      t.references :action, null: false, foreign_key: true

      t.timestamps
    end
  end
end
