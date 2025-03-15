class CreateSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :steps, id: :string do |t|
      t.integer :pattern, null: false, comment: 'パターン'
      t.text :args, null: false,  comment: '引数'
      t.references :action, null: false, foreign_key: true, type: :uuid, comment: 'アクションID'
      t.timestamps
    end
    # actionsのsptesカラムを削除
    remove_column :actions, :steps, :text
  end
end
