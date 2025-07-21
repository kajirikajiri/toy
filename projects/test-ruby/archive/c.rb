# https://gist.github.com/kyrylo/6413067
# 継承の場合
# ANCESTRY LOOKUP
require "test/unit"
include Test::Unit::Assertions

class D
  X = 5
end

class A
  class B
    class C < D
      # A constant lookup through the ancestry tree is implied
      # from the syntax we used to define the class. Anytime you
      # see the syntax A::B::C (in a class definition or expression)
      # you know constant lookup is going through the ancestry tree.
      #
      # C is asked does 'X' exist in its constant table, it does not.
      # Next the superclass of C is asked, which is D. D finds 'X' in
      # its constant table with a value of 5.
      #
      # neither B or A are asked for the constant like in a lexical
      # lookup. If X were not defined, C would be asked first, then
      # D(the superclass of C), then its superclass(Object) is asked,
      # at which point a NameError is raised.
      #
      assert X == 5
    end
  end
end

