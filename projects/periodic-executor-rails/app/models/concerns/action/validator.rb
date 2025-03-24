module Action::Validator
  TYPE = %w[Video].freeze
  extend ActiveSupport::Concern
  included do
    # executable_typeは指定されたもののみ
    validates :executable_type, inclusion: { in: TYPE }
  end
end
