module Action::Validator
  TYPE = %w[Video].freeze
  extend ActiveSupport::Concern
  included do
    # executable_typeは指定されたもののみ
    validates :executable_type, inclusion: { in: TYPE }
    # logsはJSON形式
    validates :logs, json: true, allow_nil: true
  end
end
