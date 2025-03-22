module Resolvers
  class GetUnexecutedActionResolver < BaseResolver
    type Types::ActionType, null: true

    # 今日の日付で未実行の一番古いスクレイプを取得
    def resolve
      Action.where(created_at: Time.zone.today.all_day, completed_at: nil).first
    end
  end
end