class CreateCricketers < ActiveRecord::Migration[7.1]
  def change
    create_table :cricketers do |t|
      t.float :batting_average

      t.timestamps
    end
  end
end
