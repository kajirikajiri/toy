class CreateActionsJob < ApplicationJob
  queue_as :default

  def perform
    # ウォッチリストのビデオを登録するActionを作成する
    watch_list = WatchList.find_or_create_by!(url: 'https://www.amazon.co.jp/gp/video/mystuff/watchlist')
    Action.create!(executable_id: watch_list.id, executable_type: 'WatchList', pattern: Action.patterns[:create_videos_for_watch_list])

    # Videoの全レコードに対してActionを作成する
    Video.find_each do |video|
      # 今日既にスクレイプレコードを作成している場合はスキップ
      next if Action.exists?(executable_type: 'Video', executable_id: video.id, created_at: Time.zone.today.all_day, pattern: Action.patterns[:update_video_episode_count])

      Action.create!(executable_id: video.id, executable_type: 'Video', pattern: Action.patterns[:update_video_episode_count])
    end
  end
end
