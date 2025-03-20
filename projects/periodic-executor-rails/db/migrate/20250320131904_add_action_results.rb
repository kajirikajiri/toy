class AddActionResults < ActiveRecord::Migration[8.0]
  def change
    create_table :action_results, id: :string  do |t|
      t.boolean :success, null: false, default: false
      t.text :steps, null: false
      t.references :action, null: false, foreign_key: true
      t.timestamps
    end
  end
end
