class Player < ApplicationRecord
  delegated_type :playerable, types: %w[Footballer Cricketer]
  delegate :special_feature, to: :playerable
end
