class Video::Callback

  class << self

    def after_create(video)
      after_create_create_scrape(video)
    end
    
    def after_update(video)
      after_update_incremented_episode_count_send_notification(video)
    end
    
    # videoを作成したら、初回のスクレイピングを実行するためにScrapeを作成する
    def after_create_create_scrape(video)
      Scrape.create!(video:)
    end
    
    # video更新時、episode_countが増えた場合にSlackに通知する
    def after_update_incremented_episode_count_send_notification(video)
      # episode_countが増えていない場合は何もしない
      return if (video.episode_count_before_last_save || 0) >= video.episode_count

      SlackMessage.create!(channel: SlackMessage::CHANNELS[:chrome_bot], text: "新着エピソードあり #{video.title}")
    end
  end
end