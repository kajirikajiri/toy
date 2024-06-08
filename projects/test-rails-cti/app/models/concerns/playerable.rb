module Playerable
  extend ActiveSupport::Concern

  included do
    has_many :players, as: :playerable
  end
end
