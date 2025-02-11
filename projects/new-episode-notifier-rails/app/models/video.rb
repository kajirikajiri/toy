# == Schema Information
#
# Table name: videos
#
#  id            :string           not null, primary key
#  episode_count :integer
#  url           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_videos_on_url  (url) UNIQUE
#
class Video < ApplicationRecord
  has_many :scrapes, dependent: :destroy
  
  after_create Callbacks
end
