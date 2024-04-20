class AddDescriptionToTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :description, :string
  end
end
