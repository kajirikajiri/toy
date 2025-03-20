class AddOrderInStep < ActiveRecord::Migration[8.0]
  def change
    add_column :steps, :order, :integer, null: false, default: 0
    # action_idとorderの組み合わせで一意性を持たせる
    add_index :steps, [:action_id, :order], unique: true
  end
end
