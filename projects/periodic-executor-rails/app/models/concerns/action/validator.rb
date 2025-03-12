module Action::Validator
  extend ActiveSupport::Concern

  included do
    validates :steps, json: true
    validates :name, presence: true
  end
end
