require "test_helper"

class ScrapeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: scrapes
#
#  id          :string           not null, primary key
#  executed_at :datetime
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
