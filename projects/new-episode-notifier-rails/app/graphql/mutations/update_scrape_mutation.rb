module Mutations
  class UpdateScrapeMutation < BaseMutation
    argument :id, ID, required: true
    argument :executed_at, GraphQL::Types::ISO8601Date
    argument :raw_dom, String

    field :scrape, Types::ScrapeType, null: false

    def resolve(**args)
      scrape = Scrape.find(id)
      scrape.update!(args)
      { scrape: }
    end
  end
end
