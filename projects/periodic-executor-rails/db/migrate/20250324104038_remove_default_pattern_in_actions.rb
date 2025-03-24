class RemoveDefaultPatternInActions < ActiveRecord::Migration[8.0]
  def change
    change_column_default :actions,
                          :pattern,
                          from: "update_video_episode_count",
                          to: nil
  end
end
