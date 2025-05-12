require_relative '../../../lib/parent_class/child_class'

describe ParentClass::ChildClass do
  describe '#hello' do
    it "'Hello from ChildClass!'という文字列を返す" do
      expect(subject.hello).to eq('Hello from ChildClass!')
    end
  end
end
