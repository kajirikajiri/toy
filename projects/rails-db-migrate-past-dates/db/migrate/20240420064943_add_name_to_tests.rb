class AddNameToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :name, :string
  end
end
