class Step < ApplicationRecord
  include Step::Validator

  belongs_to :action
  enum :pattern, {
    get_count: 0, # 要素の数を取得
    get_inner_text: 1, # 要素のテキストを取得
    create_tab: 2, # ブラウザタブを作成
    trim_output: 3, # 他stepの出力をトリミング
    logging_output: 4, # 他stepの出力をログに出力
    logging_string: 5, # 文字列をログに出力
  }

  # hashならjsonに変換してセット
  def args=(value)
    super(value.is_a?(Hash) ? value.to_json : value)
  end
end

# == Schema Information
#
# Table name: steps
#
#  id         :string           not null, primary key
#  args       :text             not null
#  pattern    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  action_id  :uuid             not null
#
# Indexes
#
#  index_steps_on_action_id  (action_id)
#
# Foreign Keys
#
#  action_id  (action_id => actions.id)
#
