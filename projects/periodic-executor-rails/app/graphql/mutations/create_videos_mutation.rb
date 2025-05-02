module Mutations
  class CreateVideosMutation < BaseMutation
    argument :action_id, ID, required: true
    argument :browser_extension_result, Types::ActionEnumBrowserExtensionResult, required: true
    argument :videos, [Types::VideoInput], required: false

    field :action, Types::ActionType, null: true

    def resolve(**params)
      action = Action.find(params[:action_id])
      raise GraphQL::ExecutionError, "action executable is not a WatchList" unless action.executable_type == "WatchList"

      attributes = params.slice(:browser_extension_result, :videos)
      form = Action::Form::CreateVideos.new(attributes, action: action)
      form.save!
      { action: action }
    end
  end
end
