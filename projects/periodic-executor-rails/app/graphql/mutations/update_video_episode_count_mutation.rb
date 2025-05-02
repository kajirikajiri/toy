module Mutations
  class UpdateVideoEpisodeCountMutation < BaseMutation
    argument :id, ID, required: true
    argument :episode_count, Integer, required: false
    argument :browser_extension_result, Types::ActionEnumBrowserExtensionResult, required: true

    field :action, Types::ActionType, null: false

    def resolve(**params)
      action = Action.find(params[:id])
      raise GraphQL::ExecutionError, "action executable is not a video" unless action.executable_type == "Video"
      
      video = action.executable
      attributes = params.slice(:episode_count, :browser_extension_result)
      form = Action::Form::UpdateVideoEpisodeCount.new(
        attributes,
        action: action,
        video: video
      )

      form.save!
      { action: action }
    end
  end
end
