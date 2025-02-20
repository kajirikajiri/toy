module SlackMessage::Validator
  extend ActiveSupport::Concern

  included do
    validates :response, json: true, allow_nil: true
  end
end
