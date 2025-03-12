module Action::Validator
  extend ActiveSupport::Concern

  STEPS_SCHEMA = {
    type: 'array',
    items: {
      oneOf: [
        {
          type: 'object',
          properties: {
            id: { type: 'string' },
            name: { type: 'string', const: 'getCount' },
            selector: { type: 'string' },
          },
        },
        {
          type: 'object',
          properties: {
            id: { type: 'string' },
            name: { type: 'string', const: 'getInnerText' },
            selector: { type: 'string' },
          },
        },
        {
          type: 'object',
          properties: {
            id: { type: 'string' },
            name: { type: 'string', const: 'createTab' },
            args: {
              type: 'object',
              properties: {
                url: { type: 'string' },
                waitLoadedMs: { type: 'integer' } 
              }
            }
          },
        },
        {
          type: 'object',
          properties: {
            id: { type: 'string' },
            name: { type: 'string', const: 'trimText' },
            args: {
              type: 'object',
              properties: {
                replaced: { type: 'string' }, # stepのIDを指定し値を取得
                pattern: { type: 'string' }, # 正規表現
                replacement: { type: 'string' }, # 置換後の文字列
              }
            }
          },
        }
      ]
    }
  }.freeze

  included do
    validates :steps, json: { schema: STEPS_SCHEMA }
    validates :name, presence: true
  end
end
