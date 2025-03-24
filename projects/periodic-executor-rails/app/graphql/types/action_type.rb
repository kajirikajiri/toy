class Types::ActionType < Types::BaseObject
  class Types::ActionStatus < Types::BaseEnum
      Action.statuses.keys.each do |status|
        value status
      end
  end
  class Types::ActionPattern < Types::BaseEnum
    Action.patterns.keys.each do |pattern|
      value pattern
    end
  end
  class Types::ActionResult < Types::BaseEnum
    Action.results.keys.each do |result|
      value result
    end
  end
  class Types::ActionBrowserExtensionResult < Types::BaseEnum
    Action.browser_extension_results.keys.each do |result|
      value result
    end
  end
  class ExecutableType < Types::BaseUnion
    possible_types Types::VideoType
  
    # Optional: if this method is defined, it will override `Schema.resolve_type`
    def self.resolve_type(object, context)
      case object
      when Video
        Types::VideoType
      else
        raise("Unexpected object: #{object}")
      end
    end
  end
  field :id, ID, null: false
  field :completed_at, GraphQL::Types::ISO8601DateTime, null: true
  field :executable_type, String, null: false
  field :executable, ExecutableType, null: false
  field :log, GraphQL::Types::JSON, null: true
  field :pattern, Types::ActionPattern, null: false
  field :status, Types::ActionStatus, null: false
  field :result, Types::ActionResult, null: false
  field :browser_extension_result, Types::ActionBrowserExtensionResult, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
end