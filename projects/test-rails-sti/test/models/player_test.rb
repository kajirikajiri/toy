require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "Player" do
    player = Player.create!(name: "Player 1")
    assert_equal nil, player.type
    assert_equal "Player 1", player.name
  end

  test "Footballer" do
    player = Player::Footballer.create!(name: "Footballer 1")
    assert_equal "Player::Footballer", player.type
    assert_equal "Footballer 1", player.name
  end

  test "Cricketer" do
    player = Player::Cricketer.create!(name: "Cricketer 1")
    assert_equal "Player::Cricketer", player.type
    assert_equal "Cricketer 1", player.name
  end

  test "Bowler" do
    player = Player::Cricketer::Bowler.create!(name: "Bowler 1")
    assert_equal "Player::Cricketer::Bowler", player.type
    assert_equal "Bowler 1", player.name
  end
end
