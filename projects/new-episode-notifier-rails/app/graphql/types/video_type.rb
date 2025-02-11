class Types::VideoType < Types::BaseObject
  field :scrapes, [Types::ScrapeType], null: false

  field :id, ID, null: false
  field :url, String, null: false
  field :episode_count, Integer
end