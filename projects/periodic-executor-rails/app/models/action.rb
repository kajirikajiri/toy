class Action < ApplicationRecord
  include Validator
  has_many :steps, dependent: :destroy
end

# == Schema Information
#
# Table name: actions
#
#  id         :string           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
