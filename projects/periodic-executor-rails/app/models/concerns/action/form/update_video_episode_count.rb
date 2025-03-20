class Action::Form::UpdateVideoEpisodeCount
  include ActiveModel::Model
  attr_accessor :attributes, :action_result, :video

  # stepsはRESULT_SCHEMAに従う
  def initialize(attributes = {}, action:, video:)
    raise ArgumentError, "action is required" if action.nil?
    raise ArgumentError, "steps is required" if steps.nil?
    raise ArgumentError, "video is required" if video.nil?

    @action = action
    @steps = steps
    @video = video
    @attributes = attributes
  end

  def save
    save!
  rescue ActiveRecord::RecordInvalid
    false
  end

  def save!
  end
end