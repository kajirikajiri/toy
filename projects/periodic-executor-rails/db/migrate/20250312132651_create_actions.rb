class CreateActions < ActiveRecord::Migration[8.0]
  def change
    create_table :actions, id: :string do |t|
      t.string :name, null: false, comment: 'アクション名'
      t.text :steps, null: false, comment: 'アクションのステップ'
      t.timestamps
    end
  end
end
