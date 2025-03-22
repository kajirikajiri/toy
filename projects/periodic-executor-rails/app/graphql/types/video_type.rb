class Types::VideoType < Types::BaseObject
  field :id, ID, null: false
  field :url, String, null: false
  field :episode_count, Integer
end