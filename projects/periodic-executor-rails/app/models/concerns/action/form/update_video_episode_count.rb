class Action::Form::UpdateVideoEpisodeCount
  include ActiveModel::Model
  attr_accessor :attributes, :action, :video

  # stepsはRESULT_SCHEMAに従う
  def initialize(attributes = {}, action:, video:)
    raise ArgumentError, "action is required" if action.nil?
    raise ArgumentError, "video is required" if video.nil?

    @action = action
    @video = video
    @attributes = attributes
  end

  def save
    save!
  rescue ActiveRecord::RecordInvalid
    false
  end

  def save!
    old_episode_count = video.episode_count
    new_episode_count = attributes[:episode_count]
    log = {}
    log[:episode_count] = "#{old_episode_count} -> #{new_episode_count}"
    log[:frontend_log] = attributes[:log] if attributes[:log].present?
    if old_episode_count.present? && old_episode_count >= new_episode_count
      action.update!(status: Action::statuses[:completed], log: log)
      return
    end

    ActiveRecord::Base.transaction do
      video.update!(episode_count: new_episode_count)
      action.update!(completed_at: Time.current, status: Action::statuses[:completed], log: log)
      slack_message = SlackMessage.create!(channel: SlackMessage::CHANNELS[:chrome_bot], text: "新着エピソードあり #{video.title} #{attributes[:episode_count]}話")
      PostSlackMessageJob.perform_later(slack_message.id)
    end
  end
end