class CreateActionsJob < ApplicationJob
  queue_as :default

  # Videoの全レコードに対してActionを作成する
  def perform
    Video.find_each do |video|
      # 今日既にスクレイプレコードを作成している場合はスキップ
      next if Action.exists?(executable_type: 'Video', executable_id: video.id, created_at: Time.zone.today.all_day, pattern: Action.patterns[:update_video_episode_count])

      Action.create!(executable_id: video.id, executable_type: 'Video', pattern: Action.patterns[:update_video_episode_count])
    end
  end
end
