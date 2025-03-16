module Action::Validator
  extend ActiveSupport::Concern
  included do
    validates :name, presence: true
    # 必ず1つ以上のstepが必要
    validates :steps, presence: true
  end
end
