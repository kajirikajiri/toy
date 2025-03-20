class Action < ApplicationRecord
  include Validator
  has_many :steps, dependent: :destroy
  has_many :action_results, dependent: :destroy

  enum :pattern, {
    update_video_episode_count: 0, # エピソード数を更新
  }
end

# == Schema Information
#
# Table name: actions
#
#  id         :string           not null, primary key
#  pattern    :integer          default("update_video_episode_count"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
