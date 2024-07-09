require 'rails_helper'

RSpec.describe HelloWorld, type: :model do
  # https://zenn.dev/ebina_shohei/articles/4ad522b62a7562
  describe 'stub_constでconcernをテスト' do
    before do
      stub_const('HelloWorldTest', Class.new { include HelloWorld })
    end

    it 'concernで定義したメソッドを呼び出せること' do
      expect(HelloWorldTest.new.example_method).to eq('Hello, World!')
    end
  end

  describe 'Class.newで動的にclassを生成してconcernをテスト' do
    let(:dummy_class) { Class.new { include HelloWorld } }

    it 'concernで定義したメソッドを呼び出せること' do
      expect(dummy_class.new.example_method).to eq('Hello, World!')
    end
  end
end

# 記事中にあるように、テスト中で同じクラスを再定義すると、他のテストに影響を与える可能性があるので、注意が必要。
# https://zenn.dev/ebina_shohei/articles/4ad522b62a7562
# RSpec.describe SomeModule1 do
#   class DummyClass
#     include SomeModule
#   end
#
#   describe ".upcase" do
#     context "小文字の引数が渡されたとき" do
#       it "大文字に変換されること" do
#         expect(DummyClass.upcase("aaa")).to eq("AAA")
#       end
#     end
#   end
# end
#
# RSpec.describe SomeModule2 do
#   # DummyClass を再定義することで .upcase が上書きされる
#   class DummyClass
#     def self.upcase(arg)
#       "#{arg.upcase}!!!"
#     end
#   end
#
#   describe ".upcase" do
#     context "小文字の引数が渡されたとき" do
#       it "大文字に変換され、末尾に!!!がついていること" do
#         expect(DummyClass.upcase("aaa")).to eq("AAA!!!")
#       end
#     end
#   end
# end
