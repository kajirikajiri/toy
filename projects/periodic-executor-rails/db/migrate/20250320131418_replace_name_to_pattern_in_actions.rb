class ReplaceNameToPatternInActions < ActiveRecord::Migration[8.0]
  def change
    remove_column :actions, :name, :string, null: false
    add_column :actions, :pattern, :integer, null: false, default: 0
  end
end
