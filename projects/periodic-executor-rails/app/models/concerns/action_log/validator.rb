module ActionResult::Validator
  extend ActiveSupport::Concern
  included do
    validate :validate_steps_schema

    private

    def validate_steps_schema
      steps.each do |step|
        pattern = step['pattern']
        args = step['args']
        schema = Step::Validator::RESULT_SCHEMA[pattern.to_sym]
        raise "Invalid pattern: #{pattern}" unless schema
        JSON::Validator.validate!(schema, args, strict: true)
      end
    rescue JSON::Schema::ValidationError => e
      errors.add(:args, e.message)
    end
  end
end
