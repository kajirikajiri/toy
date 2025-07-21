# module prepend
# 指定したモジュールを self の継承チェインの先頭に「追加する」
# 実際の処理は modules の各要素の prepend_features を後ろから順に呼びだすだけです
# https://docs.ruby-lang.org/ja/latest/method/Module/i/prepend.html
# https://qiita.com/leon-joel/items/f7c4643023f44def5ebd#class%E5%86%85%E3%81%A7extend%E3%81%99%E3%82%8B%E4%BE%8B
# https://zenn.dev/portinc/articles/yuki_hara_ruby_const#%E7%B5%B6%E5%AF%BE%E5%8F%82%E7%85%A7%E3%81%A8%E3%81%AF%EF%BC%9F

module X
  def foo
    puts "X1" # (1x)
    super # (2x)
    puts "X2" # (3x)
  end
end

class A
  prepend X

  def foo
    puts "A" #(1a)
  end
end

A.new.foo
# (1x) (2x)(ここの super で A#foo を呼びだす) (1a) (3x) の順に実行される
# >> X1
# >> A
# >> X2

p A.ancestors
# [X, A, Object, Kernel, BasicObject]

class C
  def foo
    puts "A" #(1a)
  end
end

class D < C
  def foo
    puts "X1" # (1x)
    super # (2x)
    puts "X2" # (3x)
  end
end

D.new.foo
# X1
# A
# X2

p D.ancestors
# [D, C, Object, Kernel, BasicObject]
