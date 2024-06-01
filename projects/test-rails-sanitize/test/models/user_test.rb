require 'test_helper'
require "minitest/autorun"

describe User do
  # https://railsguides.jp/security.html#sql%E3%82%A4%E3%83%B3%E3%82%B8%E3%82%A7%E3%82%AF%E3%82%B7%E3%83%A7%E3%83%B3
  describe "where SQL injection" do
    it do
      User.create!(name: "foo")
      puts User.where("name = 'foo'").to_sql
      # SELECT `users`.* FROM `users` WHERE (name = 'foo')
      assert User.where("name = 'foo'").present?
    end
    it do
      User.create!(name: "foo")
      puts User.where("name = 'foo' OR ''").to_sql
      # SELECT `users`.* FROM `users` WHERE (name = 'foo' OR '')
      assert User.where("name = 'foo' OR ''").present?
    end
    it do
      User.create!(name: "foo")
      param = "foo' OR '"
      puts User.where("name = '#{param}'").to_sql
      # SELECT `users`.* FROM `users` WHERE (name = 'foo' OR '')
      assert User.where("name = '#{param}'").present?
    end
    it do
      User.create!(name: "foo' OR '")
      param = "foo' OR '"
      puts User.where("name = ?", param).to_sql
      # SELECT `users`.* FROM `users` WHERE (name = 'foo\' OR \'')
      assert User.where("name = ?", param).present?
    end
    it "1" do
      User.create!(name: "foo' OR '")
      param = "foo' OR '"
      puts User.where("name = :name", name: param).to_sql
      # SELECT `users`.* FROM `users` WHERE (name = 'foo\' OR \'')
      assert User.where("name = :name", name: param).present?
    end
  end
end
