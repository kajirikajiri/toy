class ActionResult < ApplicationRecord
  include Validator
  belongs_to :action
end

# == Schema Information
#
# Table name: action_logs
#
#  id         :integer          not null, primary key
#  steps      :text             not null
#  success    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  action_id  :integer          not null
#
# Indexes
#
#  index_action_logs_on_action_id  (action_id)
#
# Foreign Keys
#
#  action_id  (action_id => actions.id)
#
