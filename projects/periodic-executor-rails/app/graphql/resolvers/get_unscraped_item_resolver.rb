module Resolvers
  class GetUnscrapedItemResolver < BaseResolver
    type Types::ScrapeType, null: true

    # 今日の日付で未実行の一番古いスクレイプを取得
    def resolve
      Scrape.where(created_at: Time.zone.today.all_day, executed_at: nil).first
    end
  end
end