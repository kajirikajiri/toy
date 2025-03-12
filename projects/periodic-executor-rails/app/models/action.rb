class Action < ApplicationRecord
  include Validator

end

# == Schema Information
#
# Table name: actions
#
#  id         :string           not null, primary key
#  name       :string           not null
#  steps      :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
