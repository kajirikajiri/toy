# == Schema Information
#
# Table name: scrapes
#
#  id          :string           not null, primary key
#  executed_at :date
#  raw_dom     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  video_id    :string           not null
#
# Indexes
#
#  index_scrapes_on_video_id  (video_id)
#
# Foreign Keys
#
#  video_id  (video_id => videos.id)
#
class Scrape < ApplicationRecord
  belongs_to :video
  delegate :url, to: :video
end
