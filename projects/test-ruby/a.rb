require "test/unit"
include Test::Unit::Assertions

class A
  def self.a
    assert B == A::B
  end
end

class A::B
end

A.a # A::B

