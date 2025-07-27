# メソッドチェインしている途中で結果を見る場合のデバッグ用途で便利
# https://stackoverflow.com/questions/17493080/advantage-of-tap-method-in-ruby
# 
# INFO: .sort, .reverseの途中にtapを挟んで結果を確認している。
[3, 1, 0, 2, -1]
  .sort.tap { p it }
  .reverse.tap { p it }

# これはhelloが出力される。selfをそのまま返すため
puts 'hello'.tap { it.upcase }

# もし、selfを編集したければこのようにするが、thenの方が適切だろう
puts 'hello'.tap { it.upcase! }

# 変わった使い方として、tapでbreakすると、tapの戻り値がbreakした値になる
puts 'hello'.tap { break it.upcase }