class JsonValidator < ApplicationValidator
  def validate_each(record, attribute, value)
    JSON.parse(value)
    if options[:schema].present?
      JSON::Validator.validate!(options[:schema], value, strict: true)
    end
  rescue JSON::ParserError
    record.errors.add(attribute, 'must be a valid JSON')
  rescue JSON::Schema::ValidationError => e
    record.errors.add(attribute, options[:message] || e.message)
  end
end
