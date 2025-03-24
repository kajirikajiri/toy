class AddBrowserExtensionResultInActions < ActiveRecord::Migration[8.0]
  def change
    add_column :actions, :browser_extension_result, :integer, comment: "ブラウザ拡張機能の実行結果"
  end
end
