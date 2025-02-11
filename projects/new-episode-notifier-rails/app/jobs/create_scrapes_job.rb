class CreateScrapesJob < ApplicationJob
  queue_as :default

  def perform
    Video.find_each do |video|
      # 今日既にスクレイプレコードを作成している場合はスキップ
      next if Scrape.exists?(video:, created_at: Time.zone.today.all_day)

      Scrape.create(video:)
    end
  end
end
