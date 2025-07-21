# https://gist.github.com/kyrylo/6413067
# レキシカルの場合
# LEXICAL LOOKUP
require "test/unit"
include Test::Unit::Assertions

module C
  F = 5
  module D
    module E
      # C is asked if its constant table has 'D'. It's not.
      # The next scope is B. it also does not have 'D' in its
      # constant table. The next scope is A. A::D is found and
      # the lookup stops.
      #
      # the pattern to see here is that lookup is happening by
      # traversing back through the nested scopes. this is said
      # to be a lexical constant lookup. Anytime a class or module
      # body is defined like this constant lookup happens lexically.
      #
      assert F == 5
    end
  end
end
