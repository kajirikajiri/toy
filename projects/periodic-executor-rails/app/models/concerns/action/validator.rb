module Action::Validator
  TYPE = %w[Video].freeze
  extend ActiveSupport::Concern
  included do
    # executable_typeは指定されたもののみ
    validates :executable_type, inclusion: { in: TYPE }
    # logはJSON形式
    validates :log, json: true, allow_nil: true
  end
end
