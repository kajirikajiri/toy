require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "" do
    Player.create!(playerable: Footballer.new)
    Player.create!(playerable: Cricketer.new)

    assert_equal 1, Player.footballers.count
    assert_equal 1, Player.cricketers.count
    assert_equal "Footballer", Player.footballers.first.playerable_type
    assert_equal Footballer.last, Player.footballers.first.playerable
    assert_equal "Cricketer", Player.cricketers.first.playerable_type
    assert_equal Cricketer.last, Player.cricketers.first.playerable
    assert_equal Footballer.last, Player.footballers.first.footballer
    assert_equal Cricketer.last, Player.cricketers.first.cricketer
    assert_equal Cricketer.last, Player.footballers.first.cricketer
  end
end
