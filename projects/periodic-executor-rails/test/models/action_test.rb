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
#  id                       :string           not null, primary key
#  browser_extension_result :integer
#  completed_at             :datetime
#  executable_type          :string           not null
#  pattern                  :integer          not null
#  result                   :integer
#  status                   :integer          default("pending"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  executable_id            :string           not null
#
