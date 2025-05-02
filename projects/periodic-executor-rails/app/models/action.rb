class Action < ApplicationRecord
  include Validator

  belongs_to :executable, polymorphic: true

  enum :pattern, {
    update_video_episode_count: 0, # エピソード数を更新
    create_videos_for_watch_list: 1, # ウォッチリストからビデオを追加
  }

  enum :status, {
    pending: 0, # 未実行
    completed: 1, # 完了
    failed: 2, # 失敗
  }

  enum :browser_extension_result, {
    episode_count_fetched: 0, # エピソード数の取得に成功
    failed_to_create_tab: 1, # タブの作成に失敗
    tab_loading_not_completed: 2, # タブの読み込みが完了しない
    episode_not_found: 3, # エピソードが見つからない
    new_videos_params_fetched: 4, # ビデオの作成に必要なパラメータの取得に成功
    new_videos_params_fetch_failed: 5, # ビデオの作成に必要なパラメータの取得に失敗
  }

  enum :result, {
    # 正常系
    episode_count_updated: 0, # エピソード数が更新された
    no_change_in_episode_count: 1, # エピソード数に変更がない
    new_videos_created: 2, # ビデオが作成された
    new_videos_not_found: 3, # 新しいビデオが見つからない

    # 異常系
    episode_count_not_updated: 100, # エピソード数が更新されなかった
    videos_not_created: 101, # ビデオが作成されなかった
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
#  id                       :string           not null, primary key
#  browser_extension_result :integer
#  completed_at             :datetime
#  executable_type          :string           not null
#  pattern                  :integer          not null
#  result                   :integer
#  status                   :integer          default("pending"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  executable_id            :string           not null
#
