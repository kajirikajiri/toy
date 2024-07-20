require 'rails_helper'

# https://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
# https://api.rubyonrails.org/classes/ActiveModel/Callbacks.html
# https://geekhmer.github.io/blog/2015/03/21/ruby-on-rails-callback-classes/
# https://qiita.com/joker1007/items/2a03500017766bdb0234
RSpec.describe Callbacks, type: :model do
  create_spec_table :samples do |t|
    t.string :name
  end
  let(:klass) do
    Class.new(ApplicationRecord) do |klass|
      before_save Callbacks::ReverseStringCallback.new(:name)
      after_save Callbacks::ReverseStringCallback.new(:name)
      klass.table_name = 'samples'
      def self.name
        'Sample'
      end
    end
  end

  it do
    record = klass.new(name: 'Hello')
    record.save
    expect(record.name).to eq 'Hello'
    record.reload
    expect(record.name).to eq 'olleH'
  end
end
