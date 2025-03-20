module Mutations
  class UpdateActionFormMutation < BaseMutation
    argument :id, ID, required: true
    argument :episode_count, Integer, required: true

    field :scrape, Types::ScrapeType, null: false
    field :video, Types::VideoType, null: false

    def resolve(**params)
      scrape = Scrape.find(params[:id])
      video = scrape.video
      
      # 引数のepisode_countが現在のepisode_countより小さい場合はエラーを返す
      raise ArgumentError, "エピソード数が現在のエピソード数より少ないです #{video.episode_count} > #{params[:episode_count]}" if (video.episode_count || 0) > params[:episode_count]
      
      ActiveRecord::Base.transaction do
        scrape.update!( executed_at: Time.current)
        video.update!( episode_count: params[:episode_count])
      end

      { scrape: scrape, video: video }
    end
  end
end
