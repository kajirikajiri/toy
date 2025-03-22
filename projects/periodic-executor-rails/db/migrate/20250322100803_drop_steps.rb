class DropSteps < ActiveRecord::Migration[8.0]
  def change
    drop_table :steps, id: :string, force: :cascade do |t|
      t.integer :pattern, null: false, comment: 'パターン'
      t.text :args, null: false,  comment: '引数'
      t.references :action, null: false, foreign_key: true, type: :string, comment: 'アクションID'
      t.timestamps
    end
  end
end
