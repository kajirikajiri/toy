class JsonValidator < ApplicationValidator
  def validate_each(record, attribute, value)
    JSON.parse(value)
  rescue JSON::ParserError
    record.errors.add(attribute, 'must be a valid JSON')
  end
end
