class AddResultInActions < ActiveRecord::Migration[8.0]
  def change
    add_column :actions, :result, :integer, comment: "実行結果"
  end
end
