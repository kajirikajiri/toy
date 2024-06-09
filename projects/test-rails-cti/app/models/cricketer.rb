class Cricketer < ApplicationRecord
  include Playerable

  def special_feature
    "Cricketer"
  end
end
