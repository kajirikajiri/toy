class Video < ApplicationRecord
  include Validator
end

# seasonはnullを許容する。season込でplatform上でユニークになっているため。

# == Schema Information
#
# Table name: videos
#
#  id            :string           not null, primary key
#  episode_count :integer
#  season        :integer          default(1)
#  title         :string           not null
#  url           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_videos_on_title_and_season  (title,season) UNIQUE
#  index_videos_on_url               (url) UNIQUE
#
