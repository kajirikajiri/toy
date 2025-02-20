module Video::Validator
  extend ActiveSupport::Concern

  included do
    validates :episode_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_nil: true
    validates :season, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  end
end
