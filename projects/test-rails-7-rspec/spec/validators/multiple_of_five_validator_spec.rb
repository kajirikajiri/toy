require 'rails_helper'

RSpec.describe MultipleOfFiveValidator, type: :model do
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

  it 'priceが5の倍数の場合、エラーが発生しないこと' do
    record = klass.new(price: 10)
    expect(record).to be_valid
  end
  it 'priceが5の倍数でない場合、エラーが発生すること' do
    record = klass.new(price: 11)
    expect(record).not_to be_valid
  end
end
