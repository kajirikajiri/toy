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
require "test_helper"

class VideoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
