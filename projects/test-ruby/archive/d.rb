# https://zenn.dev/portinc/articles/yuki_hara_ruby_const#%E7%B5%B6%E5%AF%BE%E5%8F%82%E7%85%A7%E3%81%A8%E3%81%AF%EF%BC%9F
# https://docs.ruby-lang.org/ja/latest/doc/symref.html
# https://docs.ruby-lang.org/ja/latest/doc/spec=2fvariables.html#const

require "test/unit"
include Test::Unit::Assertions

module M
  I = 35
  class C
  end
end
p M::I   #=> 35
p M::C   #=> M::C
p ::M    #=> M

M::NewConst = 777   # => 777

assert ::M == Object::M

