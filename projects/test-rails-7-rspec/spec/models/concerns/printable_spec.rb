# https://qiita.com/teitei_tk/items/772856c981f295a3cfdf
require 'rails_helper'

describe Printable, type: :model do
  before(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.create_table :pritable_tests do |t|
      t.string :name
    end
  end

  after(:all) do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.drop_table :pritable_tests
  end

  # https://docs.ruby-lang.org/ja/latest/method/Class/s/new.html
  let(:dummy_class) do
    Class.new(ApplicationRecord) do
      include Printable
      def self.name
        "PritableTest"
      end
    end
  end

  describe '#print_id' do
    let(:record) { dummy_class.create }

    it do
      expect { record.print_id }.to output("#{record.id}\n").to_stdout
    end
  end

  describe '#print_name' do
    let(:record) { dummy_class.create(name: 'hoge') }

    it do
      expect { record.print_name }.to output("hoge\n").to_stdout
    end
  end
end
