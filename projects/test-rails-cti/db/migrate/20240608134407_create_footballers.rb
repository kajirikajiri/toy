class CreateFootballers < ActiveRecord::Migration[7.1]
  def change
    create_table :footballers do |t|
      t.string :club

      t.timestamps
    end
  end
end
