class Action::Form::CreateVideos
  include ActiveModel::Model
  attr_accessor :attributes, :action

  def initialize(attributes = {}, action:)
    raise ArgumentError, "action is required" if action.nil?
    @action = action
    @attributes = attributes
  end

  def save
    save!
  rescue ActiveRecord::RecordInvalid
    false
  end

  def save!
    videos = []
    slack_message = nil
    ActiveRecord::Base.transaction do
      attributes[:videos].each do |video|
        next if Video.exists?(url: video[:url])

        videos << Video.create!(
          title: video[:title],
          url: video[:url],
        )
      end
      action.update!(
        browser_extension_result: attributes[:browser_extension_result],
        status: Action.statuses[:completed],
        result: videos.count > 0 ? Action.results[:new_videos_created] : Action.results[:new_videos_not_found],
        completed_at: Time.current
      )
      if videos.count > 0
        slack_message = SlackMessage.create!(channel: SlackMessage::CHANNELS[:chrome_bot], text: "ウォッチリストのビデオを登録: #{videos.map(&:title).join(', ')}")
      end
    end
    PostSlackMessageJob.perform_later(slack_message.id) if slack_message.present?
    videos
  end
end
