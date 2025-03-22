class AddExecutableInActions < ActiveRecord::Migration[8.0]
  def change
    add_column :actions, :executable_type, :string, null: false
    add_column :actions, :executable_id, :string, null: false
  end
end
