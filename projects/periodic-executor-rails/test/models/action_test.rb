require "test_helper"

class ActionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: actions
#
#  id              :string           not null, primary key
#  completed_at    :datetime
#  executable_type :string           not null
#  log             :text
#  pattern         :integer          default("update_video_episode_count"), not null
#  status          :integer          default("pending"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  executable_id   :string           not null
#
