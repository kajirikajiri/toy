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

  # https://api.rubyonrails.org/classes/ActiveModel/Dirty.html
  describe 'ActiveModel::Dirty methods' do
    create_spec_table :samples do |t|
      t.string :name
      t.integer :age
    end
    let(:klass) do
      Class.new(ApplicationRecord) do |klass|
        klass.table_name = 'samples'
      end
    end

    it '*_change' do
      record = klass.new
      expect(record.name_change).to eq nil
      record.name = 'a'
      expect(record.name_change).to eq [nil, 'a']
      record.save!
      expect(record.name_change).to eq nil
      record.name = 'b'
      expect(record.name_change).to eq ['a', 'b']
      record.save!
      expect(record.name_change).to eq nil
    end
    it '*_changed?' do
      record = klass.new
      expect(record.name_changed?).to eq false
      record.name = 'a'
      expect(record.name_changed?).to eq true
      record.save!
      expect(record.name_changed?).to eq false
      record.name = 'b'
      expect(record.name_changed?).to eq true
      record.save!
      expect(record.name_changed?).to eq false
    end
    it '*_previous_change' do
      record = klass.new
      expect(record.name_previous_change).to eq nil
      record.name = 'a'
      expect(record.name_previous_change).to eq nil
      record.save!
      expect(record.name_previous_change).to eq [nil, 'a']
      record.name = 'b'
      expect(record.name_previous_change).to eq [nil, 'a']
      record.save!
      expect(record.name_previous_change).to eq ['a', 'b']
    end
    it '*_previously_changed?' do
      record = klass.new
      expect(record.name_previously_changed?).to eq false
      record.name = 'a'
      expect(record.name_previously_changed?).to eq false
      record.save!
      expect(record.name_previously_changed?).to eq true
      record.name = 'b'
      expect(record.name_previously_changed?).to eq true
      record.save!
      expect(record.name_previously_changed?).to eq true
    end
    it '*_previously_was' do
      record = klass.new
      expect(record.name_previously_was).to eq nil
      record.name = 'a'
      expect(record.name_previously_was).to eq nil
      record.save!
      expect(record.name_previously_was).to eq nil
      record.name = 'b'
      expect(record.name_previously_was).to eq nil
      record.save!
      expect(record.name_previously_was).to eq 'a'
    end
    it '*_was' do
      record = klass.new
      expect(record.name_was).to eq nil
      record.name = 'a'
      expect(record.name_was).to eq nil
      record.save!
      expect(record.name_was).to eq 'a'
      record.name = 'b'
      expect(record.name_was).to eq 'a'
      record.save!
      expect(record.name_was).to eq 'b'
    end
    it '*_will_change!' do
      record = klass.new
      expect(record.name_changed?).to eq false
      expect(record.age_changed?).to eq false
      expect(record.changed?).to eq false
      record.name_will_change!
      expect(record.name_changed?).to eq true
      expect(record.age_changed?).to eq false
      expect(record.changed?).to eq true
    end
    it '*_' do
    end
  end
end
