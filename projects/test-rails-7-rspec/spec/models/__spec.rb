require 'rails_helper'

describe type: :model do
  describe 'freeze_time' do
    context 'when freeze_time is called' do
      before { freeze_time }
      it { expect(Time.now).to eq Time.zone.now }
    end
    context 'when freeze_time is not called' do
      it { expect(Time.now).not_to eq Time.zone.now }
    end
  end
  describe 'enum conflict' do
    create_spec_table :samples do |t|
      t.integer :status, null: false
    end
    let(:klass) do
      Class.new(ApplicationRecord) do |klass|
        enum :status_one, { active: 0, inactive: 1 }, default: :active
        enum :status_two, { active: 0, inactive: 1 }, default: :active
        klass.table_name = 'samples'
      end
    end

    it do
      expect { klass }.to raise_error(ArgumentError, 'You tried to define an enum named "status_two" on the model "", but this will generate a instance method "active?", which is already defined by another enum.')
    end
  end
  describe 'validate_each' do
    create_spec_table :samples do |t|
      t.integer :price
    end
    let(:klass) do
      Class.new(ApplicationRecord) do |klass|
        validates :price, multiple_of_five: true
        klass.table_name = 'samples'
        def self.name
          'Sample'
        end
      end
    end

    it do
      record = klass.new(price: 10)
      expect(record).to be_valid
    end
    it do
      record = klass.new(price: 11)
      expect(record).not_to be_valid
    end
  end
end
