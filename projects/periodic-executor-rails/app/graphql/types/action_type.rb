class Types::ActionType < Types::BaseObject
  field :id, ID, null: false
  field :completed_at, GraphQL::Types::ISO8601DateTime, null: true
  field :executable_type, String, null: false
  field :executable, Types::ActionUnionExecutable, null: false
  field :log, GraphQL::Types::JSON, null: true
  field :pattern, Types::ActionEnumPattern, null: false
  field :status, Types::ActionEnumStatus, null: false
  field :result, Types::ActionEnumResult, null: false
  field :browser_extension_result, Types::ActionEnumBrowserExtensionResult, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
end