require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # https://railsguides.jp/security.html#sql%E3%82%A4%E3%83%B3%E3%82%B8%E3%82%A7%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3
  # https://api.rubyonrails.org/classes/ActiveRecord/Sanitization/ClassMethods.html#method-i-sanitize_sql_for_conditions
  test "where1" do
    User.create!(name: "foo")
    assert User.where("name = 'foo'").present?
  end
  test "where2" do
    User.create!(name: "foo")
    assert User.where("name = 'foo' OR ''").present?
  end
  test "where3" do
    User.create!(name: "foo")
    param = "foo' OR '"
    assert User.where("name = '#{param}'").present?
  end
  test "where4" do
    User.create!(name: "foo' OR '")
    param = "foo' OR '"
    assert User.where("name = ?", param).present?
  end
  test "where5" do
    User.create!(name: "foo' OR '")
    param = "foo' OR '"
    assert User.where("name = :name", name: param).present?
  end
  test "order1" do
    User.create!(name: "bar")
    User.create!(name: "foo")
    assert_equal User.order("name").map(&:name), ["bar", "foo"]
  end
  test "order2" do
    User.create!(name: "bar")
    User.create!(name: "foo")
    param = "name"
    assert_equal User.order("#{param}").map(&:name), ["bar", "foo"]
  end
  test "order3" do
    User.create!(name: "bar")
    User.create!(name: "foo")
    param = "name"
    assert_raises ActiveRecord::UnknownAttributeReference do
      User.order(['?', param]) # orderにパラメータを渡すとエラーになる
    end
  end
  test "order4" do
    User.create!(name: "bar")
    User.create!(name: "foo")
    param = "name"
    assert_equal User.order([Arel.sql('?'), param]).map(&:name), ["bar", "foo"] # こうすればorderにパラメータを渡せるが、SQLインジェクションの危険がある
  end
  test "order5" do
    User.create!(name: "bar")
    User.create!(name: "foo")
    param = "name; DELETE FROM users"
    User.order([Arel.sql('?'), param]) # DELETEが実行されなかった。されないが、ログにはDELETEが出力される
    assert_equal User.order([Arel.sql('?'), 'name']).map(&:name), ["bar", "foo"]
  end
  test "order6" do
    User.create!(name: "bar")
    User.create!(name: "foo")
    param = 'name;DELETE FROM users'
    assert_equal User.order(ActiveRecord::Base.sanitize_sql_for_order([Arel.sql('?'), param])).map(&:name), ["bar", "foo"] # DELETEは実行されない。されないが、ログにはDELETEが出力される
  end
  test "like1" do
    User.create!(name: "foo")
    User.create!(name: "foofoo")
    assert_equal User.where("name LIKE 'foo%'").map(&:name), ["foo", "foofoo"]
  end
  test "like2" do
    User.create!(name: "foo")
    User.create!(name: "foofoo")
    param = "foo%"
    assert_equal User.where("name LIKE '#{param}'").map(&:name), ["foo", "foofoo"]
  end
  test "like3" do
    User.create!(name: "foo")
    User.create!(name: "foofoo")
    param = "foo%"
    assert_equal User.where("name LIKE ?", param).map(&:name), ["foo", "foofoo"] # %がエスケープされていない
  end
  test "like4" do
    User.create!(name: "foo")
    User.create!(name: "foofoo")
    User.create!(name: "foo%_")
    param = "foo%_"
    assert_equal User.where("name LIKE ?", ActiveRecord::Base.sanitize_sql_like(param)).map(&:name), ["foo%_"] # %, _がエスケープされた
  end
  test "set1" do
    user = User.create!(name: "foo")
    user.update!(name: "bar'--") # サニタイズされた。サニタイズされなければ、whereが無効化され、全員の名前が変更される
    assert_equal User.find(user.id).name, "bar'--"
  end
  test "set2" do
    # サニタイズされない例を作る方法がわからない
    user = User.create!(name: "foo")
    user.update!(name: Arel.sql("bar'--")) # サニタイズされた。サニタイズされなければ、whereが無効化され、全員の名前が変更される
    assert_equal User.find(user.id).name, "bar'--"
  end
  test "set3" do
    sql = ActiveRecord::Base.sanitize_sql_for_assignment(["name=?", "bar'--"])
    assert_equal sql, "name='bar\\'--'"
  end
  test "set4" do
    sql = User.sanitize_sql_hash_for_assignment({name: "bar'--"}, "users")
    assert_equal sql, "`users`.`name` = 'bar\\'--'"
  end
end
