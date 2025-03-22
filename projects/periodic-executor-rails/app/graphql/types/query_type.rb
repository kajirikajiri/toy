# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :get_unexecuted_action, resolver: Resolvers::GetUnexecutedActionResolver
  end
end
