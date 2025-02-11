# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :list_scrapes, resolver: Resolvers::ListScrapeResolver
  end
end
