module Mutations
  class UpdateVideoEpisodeCountMutation < BaseMutation
    class Types::ActionBrowserExtensionResultInput < Types::BaseEnum
      Action.browser_extension_results.keys.each do |result|
        value result
      end
    end
    argument :id, ID, required: true
    argument :episode_count, Integer, required: false
    argument :browser_extension_result, Types::ActionBrowserExtensionResultInput, required: true

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
