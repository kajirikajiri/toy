class CreatePlayer < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :type
      t.string :name
      t.timestamps
    end
  end
end
