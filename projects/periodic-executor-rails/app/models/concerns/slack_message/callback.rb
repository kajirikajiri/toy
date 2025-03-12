class SlackMessage::Callback

  class << self
    def after_commit(slack_message)
      after_create_commit_post(slack_message)
    end

    # レコードの作成時にPostSlackMessageJobを発火する
    def after_create_commit_post(slack_message)
      # レコード作成以外なら何もしないためにreturnする
      return unless slack_message.previous_changes.key?("id")

      PostSlackMessageJob.perform_later(slack_message.id)
    end
  end
end

