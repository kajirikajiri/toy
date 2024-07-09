require 'rails_helper'

RSpec.describe HelloWorld, type: :model do
  let(:dummy_class) { Class.new { include HelloWorld } }
  let(:dummy_instance) { dummy_class.new }

  it 'responds to example_method' do
    expect(dummy_instance.example_method).to eq('Hello, World!')
  end
end
