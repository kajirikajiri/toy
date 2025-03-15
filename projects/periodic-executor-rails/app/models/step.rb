class Step < ApplicationRecord
  include Step::Validator

  belongs_to :action
  enum :pattern, {
    get_count: 0,
    get_inner_text: 1,
    create_tab: 2,
    trim_text: 3
  }
end

# == Schema Information
#
# Table name: steps
#
#  id         :string           not null, primary key
#  args       :text             not null
#  pattern    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  action_id  :uuid             not null
#
# Indexes
#
#  index_steps_on_action_id  (action_id)
#
# Foreign Keys
#
#  action_id  (action_id => actions.id)
#
