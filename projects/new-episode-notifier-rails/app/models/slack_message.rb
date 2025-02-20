class SlackMessage < ApplicationRecord
  include Validator

  after_commit Callback

  CHANNELS = {
    chrome_bot: ENV.fetch('SLACK_CHANNEL_ID_CHROME_BOT'),
  }

  enum :status, {
    pending: 0, # 未送信
    success: 1, # 送信成功
    failure: 2, # 送信失敗
  }
  
  def post!
    raise TypeError, 'すでに送信済みです' if status == 'success'

    begin
      response = SlackService.new.post(
        channel:,
        text:,
        thread_ts:,
      )
      update!(status: :success, response: response.to_json, ts: response['ts'])
    # 例外は再度raiseする
    # responseを取得できる場合は、response,tsを更新する
    rescue Slack::Web::Api::Errors::SlackError, Slack::Web::Api::Errors::TooManyRequestsError, Slack::Web::Api::Errors::ServerError => e
      response = e.response
      update!(status: :failure, response:)
      raise e
    rescue StandardError => e
      update!(status: :failure)
      raise e
    end
  end
end

# == Schema Information
#
# Table name: slack_messages
#
#  id         :string           not null, primary key
#  channel    :string           not null
#  response   :text
#  status     :integer          default("pending"), not null
#  text       :string
#  thread_ts  :string
#  ts         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
