require 'rails_helper'

RSpec.describe SnakeCaseNameValidator, type: :model do
  create_spec_table :samples do |t|
    t.string :name
  end
  let(:klass) do
    Class.new(ApplicationRecord) do |klass|
      validates_with SnakeCaseNameValidator
      klass.table_name = 'samples'
      def self.name
        'Sample'
      end
    end
  end

  it 'nameがスネークケースでない場合、エラーが発生すること' do
    record = klass.new(name: 'SampleName')
    expect(record).to be_invalid
  end
  it 'nameがスネークケースの場合、エラーが発生しないこと' do
    record = klass.new(name: 'sample_name')
    expect(record).to be_valid
  end
end
