class Video::Callbacks

  class << self

    def after_create(video)
      after_create_create_scrape(video)
    end
    
    # videoを作成したら、初回のスクレイピングを実行するためにScrapeを作成する
    def after_create_create_scrape(video)
      Scrape.create!(video:)
    end
    
    # video更新時、episode_countが増えた場合かつ、episode_countが0でない場合に通知を作成する
    def after_update_incremented_episode_count_send_notification(video)
      return unless video.episode_count.positive? && video.episode_count_before_last_save < video.episode_count

      # 後で通知を作成する処理を追加する
      puts "New episode is detected! #{video.title}"
    end
  end
end