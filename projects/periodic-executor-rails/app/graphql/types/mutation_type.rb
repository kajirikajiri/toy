# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :update_video_episode_count, mutation: Mutations::UpdateVideoEpisodeCountMutation
    field :create_videos, mutation: Mutations::CreateVideosMutation
  end
end
