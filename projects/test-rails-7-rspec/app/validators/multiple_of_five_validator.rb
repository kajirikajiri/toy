class MultipleOfFiveValidator < ApplicationEachValidator
  def validate_each(record, attribute, value)
    unless value % 5 == 0
      record.errors.add(attribute, "must be a multiple of 5")
    end
  end
end
