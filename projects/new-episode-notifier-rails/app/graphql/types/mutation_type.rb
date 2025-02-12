# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :update_scraped_data, mutation: Mutations::UpdateScrapedDataMutation
  end
end
