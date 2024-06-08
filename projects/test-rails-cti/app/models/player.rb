class Player < ApplicationRecord
  delegated_type :playerable, types: %w[Footballer Cricketer]
end
