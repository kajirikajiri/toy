# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :get_unscraped_item, resolver: Resolvers::GetUnscrapedItemResolver
  end
end
