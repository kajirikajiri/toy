class Action < ApplicationRecord
  include Validator

  belongs_to :executable, polymorphic: true

  enum :pattern, {
    update_video_episode_count: 0, # エピソード数を更新
  }
  enum :status, {
    pending: 0, # 未実行
    completed: 1, # 完了
    failed: 2, # 失敗
  }

  # logのセッターでhashならjsonにする
  def log=(value)
    super(value.is_a?(Hash) ? value.to_json : value)
  end
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
