class RemoveLogColumnInAction < ActiveRecord::Migration[8.0]
  def change
    remove_column :actions, :log, :text
  end
end
