class SnakeCaseNameValidator < ApplicationValidator
  def validate(record)
    record.errors.add(:name, :snake_case_name) unless record.name =~ /\A[a-z_]+\z/
  end
end
