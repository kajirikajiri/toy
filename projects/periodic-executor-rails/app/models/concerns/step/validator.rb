module Step::Validator
  extend ActiveSupport::Concern
  included do
    validates :pattern, presence: true
    validates :args, presence: true
    validate :validate_args_schema

    SCHEMA = {
      get_count: {
        type: 'object',
        properties: {
          selector: { type: 'string' },
        },
      },
      get_inner_text: {
        type: 'object',
        properties: {
          selector: { type: 'string' },
        },
      },
      create_tab: {
        type: 'object',
        properties: {
          url: { type: 'string' },
          waitLoadedMs: { type: 'integer' },
        },
      },
      trim_output: {
        type: 'object',
        properties: {
          replaced_target_step_id: { type: 'string' },
          pattern: { type: 'string' }, # regexp
          replacement: { type: 'string' },
        },
      },
      logging_output: {
        type: 'object',
        properties: {
          message_target_step_id: { type: 'string' },
        },
      },
      logging_string: {
        type: 'object',
        properties: {
          message: { type: 'string' },
        },
      },
      update_video_episode_count: {
        type: 'object',
        properties: {
          video_id: { type: 'string' },
          episode_count_step_id: { type: 'string' }, # get_countのstep_id
        },
      },
    }

    # ステップのスキーマに実行結果を追加した
    RESULT_SCHEMA = SCHEMA.transform_values do |schema|
      schema.deep_dup.tap do |s|
        s[:properties][:result] = {
          type: 'object',
          properties: {
            status: { type: 'string', enum: ['success', 'failure', 'pending'], default: 'pending' },
            message: { type: 'string' }
          }
        }
      end
    end

    private

    def validate_args_schema
      schema = SCHEMA[pattern.to_sym]
      raise "Invalid pattern: #{pattern}" unless schema
      JSON::Validator.validate!(schema, args, strict: true)
    rescue JSON::Schema::ValidationError => e
      errors.add(:args, e.message)
    end
  end
end
