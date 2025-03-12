class SlackService
  def post(channel:, text: nil, thread_ts: nil)
    self.class.client.chat_postMessage(channel:, text:, thread_ts:)
  end
  
  def self.client
    @client ||= Slack::Web::Client.new
  end
end