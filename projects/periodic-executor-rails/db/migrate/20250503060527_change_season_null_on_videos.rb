class ChangeSeasonNullOnVideos < ActiveRecord::Migration[8.0]
  def change
    change_column_null :videos, :season, true
  end
end
