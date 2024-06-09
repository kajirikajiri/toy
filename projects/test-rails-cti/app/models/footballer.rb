class Footballer < ApplicationRecord
  include Playerable

  def special_feature
    "Footballer"
  end
end
