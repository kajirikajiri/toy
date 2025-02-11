class Types::ScrapeType < Types::BaseObject
  field :video, Types::VideoType, null: false

  field :id, ID, null: false
  field :executed_at, String
  field :raw_dom, String
  field :url, String, null: false, method: :url
end