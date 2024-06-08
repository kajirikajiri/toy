class UpdatePlayer < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :club, :string
    add_column :players, :batting_average, :float
    add_column :players, :bowling_average, :float
  end
end
