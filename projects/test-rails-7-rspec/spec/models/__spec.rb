require 'rails_helper'

# https://qiita.com/teitei_tk/items/772856c981f295a3cfdf
# テスト用のテーブルを作成するためのヘルパーメソッド
def create_spec_table(name, &block)
  before(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.create_table name, &block
  end

  after(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.drop_table name
  end
end

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
end
