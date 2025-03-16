module Step::Validator
  extend ActiveSupport::Concern
  included do
    validates :pattern, presence: true
    validates :args, presence: true
    validate :validate_args_schema

    private

    def validate_args_schema
      schema = case pattern
      when 'get_count'
        {
          type: 'object',
          properties: {
            selector: { type: 'string' },
          },
        }
      when 'get_inner_text'
        {
          type: 'object',
          properties: {
            selector: { type: 'string' },
          }
        }
      when 'create_tab'
        {
          type: 'object',
          properties: {
            url: { type: 'string' },
            waitLoadedMs: { type: 'integer' }
          },
        }
      when 'trim_output'
        {
          type: 'object',
          properties: {
            replaced_target_step_id: { type: 'string' },
            pattern: { type: 'string' }, # regexp
            replacement: { type: 'string' },
          },
        }
      when 'logging_output'
        {
          type: 'object',
          properties: {
            message_target_step_id: { type: 'string' },
          },
        }
      when 'logging_string'
        {
          type: 'object',
          properties: {
            message: { type: 'string' },
          },
        }
      else
        raise "Invalid pattern: #{pattern}"
      end
      JSON::Validator.validate!(schema, args, strict: true)
    rescue JSON::Schema::ValidationError => e
      errors.add(:args, e.message)
    end
  end
end
