class RemoveUnexecutedScrapesJob < ApplicationJob
  queue_as :default

  # 昨日までに作成されたが実行されていないスクレイプレコードを削除する
  def perform
    Scrape.where(created_at: ..Time.zone.yesterday.end_of_day, executed_at: nil).destroy_all
  end
end
