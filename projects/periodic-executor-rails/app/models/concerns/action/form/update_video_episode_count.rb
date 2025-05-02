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
    browser_extension_result = attributes[:browser_extension_result]
    if new_episode_count.blank?
      action.update!(status: Action::statuses[:completed], result: Action.results[:episode_count_not_updated], browser_extension_result: browser_extension_result)
      return
    end

    slack_message = nil
    ActiveRecord::Base.transaction do
      result = Action.results[:no_change_in_episode_count]
      if (old_episode_count.present? && new_episode_count.present? && (old_episode_count < new_episode_count)) || (old_episode_count.blank? && new_episode_count.present?)
        result = Action.results[:episode_count_updated]
        video.update!(episode_count: new_episode_count)
        slack_message = SlackMessage.create!(channel: SlackMessage::CHANNELS[:chrome_bot], text: "新着エピソードあり #{video.title} #{new_episode_count}話")
      end
      action.update!(completed_at: Time.current, status: Action::statuses[:completed], result:, browser_extension_result:)
    end
    PostSlackMessageJob.perform_later(slack_message.id) if slack_message.present?
  end
end