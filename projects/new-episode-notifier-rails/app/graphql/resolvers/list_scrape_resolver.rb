module Resolvers
  class ListScrapeResolver < BaseResolver
    type [Types::ScrapeType], null: false

    def resolve
      Scrape.where(created_at: Time.zone.today.all_day)
    end
  end
end