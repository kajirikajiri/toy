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
    assert_equal "Cricketer", Player.cricketers.first.special_feature
    assert_equal "Cricketer", Player.all.preload(:playerable).last.special_feature
  end
  test "preload" do
    Player.create!(playerable: Footballer.new)
    Player.create!(playerable: Footballer.new)
    Player.create!(playerable: Cricketer.new)
    Player.create!(playerable: Cricketer.new)

    players = Player.all.preload(:playerable)
    # D, [2024-06-09T05:50:47.662788 #261] DEBUG -- :   Player Load (0.8ms)  SELECT `players`.* FROM `players` /* loading for pp */ LIMIT 11
    # D, [2024-06-09T05:50:47.685766 #261] DEBUG -- :   Footballer Load (0.8ms)  SELECT `footballers`.* FROM `footballers` WHERE `footballers`.`id` IN (980190978, 980190979)
    # D, [2024-06-09T05:50:47.688834 #261] DEBUG -- :   Cricketer Load (0.4ms)  SELECT `cricketers`.* FROM `cricketers` WHERE `cricketers`.`id` IN (980190974, 980190975)
    players.each { |p| puts p.special_feature }
    # D, [2024-06-09T05:50:58.261819 #261] DEBUG -- :   Player Load (1.3ms)  SELECT `players`.* FROM `players`
    # D, [2024-06-09T05:50:58.270351 #261] DEBUG -- :   CACHE Footballer Load (0.1ms)  SELECT `footballers`.* FROM `footballers` WHERE `footballers`.`id` IN (980190978, 980190979)
    # D, [2024-06-09T05:50:58.274571 #261] DEBUG -- :   CACHE Cricketer Load (0.1ms)  SELECT `cricketers`.* FROM `cricketers` WHERE `cricketers`.`id` IN (980190974, 980190975)
  end
  test "not preload" do
    Player.create!(playerable: Footballer.new)
    Player.create!(playerable: Footballer.new)
    Player.create!(playerable: Cricketer.new)
    Player.create!(playerable: Cricketer.new)

    players = Player.all
    # D, [2024-06-09T05:55:15.615659 #285] DEBUG -- :   Player Load (1.3ms)  SELECT `players`.* FROM `players` /* loading for pp */ LIMIT 11
    players.each { |p| puts p.special_feature }
    # D, [2024-06-09T05:55:47.764000 #285] DEBUG -- :   Player Load (4.2ms)  SELECT `players`.* FROM `players`
    # D, [2024-06-09T05:55:47.823299 #285] DEBUG -- :   Footballer Load (1.0ms)  SELECT `footballers`.* FROM `footballers` WHERE `footballers`.`id` = 980190986 LIMIT 1
    # D, [2024-06-09T05:55:47.827006 #285] DEBUG -- :   Footballer Load (0.5ms)  SELECT `footballers`.* FROM `footballers` WHERE `footballers`.`id` = 980190987 LIMIT 1
    # D, [2024-06-09T05:55:47.832976 #285] DEBUG -- :   Cricketer Load (0.7ms)  SELECT `cricketers`.* FROM `cricketers` WHERE `cricketers`.`id` = 980190980 LIMIT 1
    # D, [2024-06-09T05:55:47.836582 #285] DEBUG -- :   Cricketer Load (0.8ms)  SELECT `cricketers`.* FROM `cricketers` WHERE `cricketers`.`id` = 980190981 LIMIT 1
  end
end
