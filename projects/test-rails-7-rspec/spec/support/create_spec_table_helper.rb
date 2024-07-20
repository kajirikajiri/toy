# テスト用のテーブルを作成するためのヘルパーメソッド
# https://qiita.com/teitei_tk/items/772856c981f295a3cfdf
module CreateSpecTableHelper
  def create_spec_table(name, &block)
    before(:all) do
      m = ActiveRecord::Migration.new
      m.verbose = false
      m.create_table name, &block
    end

    after(:all) do
      m = ActiveRecord::Migration.new
      m.verbose = false
      m.drop_table name
    end
  end
end
