class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  
  # created_atでorderされるようにする
  # firstやlastはidでorderされるので、主キーをUUIDにしている場合はランダムに並ぶため。
  self.implicit_order_column = "created_at"

  # IDはUUIDで生成する
  before_create :maybe_assign_id

  def maybe_assign_id
    self.id = self.id.presence || SecureRandom.uuid
  end
end
