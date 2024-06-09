class UpdatePlayer < ActiveRecord::Migration[7.1]
  def change
    add_reference :players, :playerable, polymorphic: true, index: true
  end
end
