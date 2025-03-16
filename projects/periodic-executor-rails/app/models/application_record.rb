class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  
  # created_atでorderされるようにする
  # firstやlastはidでorderされるので、主キーをUUIDにしている場合はランダムに並ぶため。
  self.implicit_order_column = "created_at"

  # IDはUUIDで生成する
  before_create :maybe_assign_id

  def maybe_assign_id
    self.id = self.id.presence || SecureRandom.uuid
    validate_uuid_format(self.id)
  end

  private

  def validate_uuid_format(uuid)
    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
    return true if uuid_regex.match?(uuid.to_s.downcase)

    log_and_raise_error("Given argument is not a valid UUID: '#{format_argument_output(uuid)}'")
  end
end
