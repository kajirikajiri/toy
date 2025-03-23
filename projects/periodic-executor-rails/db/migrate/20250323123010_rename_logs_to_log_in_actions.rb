class RenameLogsToLogInActions < ActiveRecord::Migration[8.0]
  def change
    rename_column :actions, :logs, :log
  end
end
