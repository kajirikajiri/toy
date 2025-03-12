class PostSlackMessageJob < ApplicationJob
  def perform(id)
    slack_message = SlackMessage.find(id)
    slack_message.post!
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
