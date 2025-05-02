class Types::VideoInput < Types::BaseInputObject
  argument :title, String, required: false
  argument :url, String, required: false
  argument :season, Integer, required: false
  argument :episode_count, Integer, required: false
end