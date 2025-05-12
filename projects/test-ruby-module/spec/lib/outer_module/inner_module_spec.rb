require_relative '../../../main'

describe OuterModule::InnerModule do
  describe '.hello' do
    it '"Hello from Inner module!"という文字列を返す' do
      expect(described_class.hello).to eq('Hello from Inner module!')
    end
  end
end
