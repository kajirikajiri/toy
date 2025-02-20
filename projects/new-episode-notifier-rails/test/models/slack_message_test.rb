require "test_helper"

class SlackMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: slack_messages
#
#  id         :string           not null, primary key
#  channel    :string           not null
#  response   :text
#  status     :integer          default("pending"), not null
#  text       :string
#  thread_ts  :string
#  ts         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
