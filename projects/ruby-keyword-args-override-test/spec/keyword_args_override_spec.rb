require 'spec_helper'

RSpec.describe "キーワード引数のメソッドオーバーライド動作検証" do
  let(:base_instance) { BaseClass.new }
  let(:child_instance) { ChildClass.new }
  let(:child_with_extras_instance) { ChildWithExtras.new }
  let(:child_no_args_instance) { ChildNoArgs.new }

  describe "BaseClass" do
    describe "#process_data" do
      it "デフォルト値を使って動作する" do
        result = base_instance.process_data(name: "田中")
        expect(result[:name]).to eq("田中")
        expect(result[:age]).to eq(20)
        expect(result[:city]).to eq("Tokyo")
        expect(result[:class_name]).to eq("BaseClass")
      end

      it "全てのパラメータを指定できる" do
        result = base_instance.process_data(name: "佐藤", age: 35, city: "Nagoya")
        expect(result[:name]).to eq("佐藤")
        expect(result[:age]).to eq(35)
        expect(result[:city]).to eq("Nagoya")
      end
    end

    describe "#calculate" do
      it "デフォルト値で計算を実行する" do
        result = base_instance.calculate(x: 5)
        expect(result).to eq(15) # 5 + 10
      end

      it "操作を変更できる" do
        result = base_instance.calculate(x: 5, y: 3, operation: :multiply)
        expect(result).to eq(15) # 5 * 3
      end
    end

    describe "#flexible_method" do
      it "任意のキーワード引数を受け取る" do
        result = base_instance.flexible_method(a: 1, b: 2, c: 3)
        expect(result[:received_keys]).to contain_exactly(:a, :b, :c)
        expect(result[:received_values]).to contain_exactly(1, 2, 3)
      end
    end
  end

  describe "ChildClass" do
    describe "#process_data" do
      it "異なるデフォルト値を使用する" do
        result = child_instance.process_data(name: "山田")
        expect(result[:name]).to eq("山田")
        expect(result[:age]).to eq(25) # BaseClassでは20
        expect(result[:city]).to eq("Osaka") # BaseClassでは"Tokyo"
        expect(result[:overridden_by]).to eq("ChildClass")
      end

      it "superを呼び出して親クラスの処理も実行する" do
        result = child_instance.process_data(name: "鈴木")
        expect(result[:class_name]).to eq("ChildClass")
        expect(result[:custom_message]).to eq("Child class with different defaults")
      end
    end

    describe "#calculate" do
      it "異なるデフォルト値で計算する" do
        result = child_instance.calculate(x: 10)
        expect(result[:result]).to eq(50) # 10 * 5 (子クラスのデフォルト)
        expect(result[:overridden_by]).to eq("ChildClass")
      end
    end

    describe "#child_specific_method" do
      it "子クラス特有のメソッドが動作する" do
        result = child_instance.child_specific_method(required_param: "必須")
        expect(result[:required_param]).to eq("必須")
        expect(result[:optional_param]).to eq("default_child")
        expect(result[:method_source]).to eq("ChildClass")
      end
    end
  end

  describe "ChildWithExtras" do
    describe "#process_data" do
      it "追加のキーワード引数を受け取る" do
        result = child_with_extras_instance.process_data(
          name: "高橋",
          age: 28,
          city: "Fukuoka",
          country: "Japan",
          hobby: "読書",
          occupation: "エンジニア"
        )
        
        expect(result[:name]).to eq("高橋")
        expect(result[:age]).to eq(28)
        expect(result[:city]).to eq("Fukuoka")
        expect(result[:country]).to eq("Japan")
        expect(result[:extra_params]).to eq({ hobby: "読書", occupation: "エンジニア" })
        expect(result[:overridden_by]).to eq("ChildWithExtras")
      end

      it "デフォルト値が適用される" do
        result = child_with_extras_instance.process_data(name: "田中")
        expect(result[:age]).to eq(30) # ChildWithExtrasのデフォルト
        expect(result[:city]).to eq("Kyoto") # ChildWithExtrasのデフォルト
        expect(result[:country]).to eq("Japan") # 新しい引数のデフォルト
      end
    end

    describe "#calculate" do
      it "追加パラメータと共に計算する" do
        result = child_with_extras_instance.calculate(
          x: 3.14159,
          y: 2.71828,
          operation: :add,
          precision: 3,
          debug: true
        )
        
        expect(result[:result]).to eq(5.86) # (3.14159 + 2.71828).round(3)
        expect(result[:precision]).to eq(3)
        expect(result[:options]).to eq({ debug: true })
        expect(result[:overridden_by]).to eq("ChildWithExtras")
      end
    end

    describe "#flexible_method" do
      it "必須パラメータと可変引数を組み合わせる" do
        result = child_with_extras_instance.flexible_method(
          required_key: "必須",
          optional1: "値1",
          optional2: "値2"
        )
        
        expect(result[:required_key]).to eq("必須")
        expect(result[:received_keys]).to contain_exactly(:optional1, :optional2)
        expect(result[:processed_by]).to eq("ChildWithExtras")
        expect(result[:has_required_param]).to be true
      end

      it "必須パラメータが無いとエラーになる" do
        expect {
          child_with_extras_instance.flexible_method(optional1: "値1")
        }.to raise_error(ArgumentError, /missing keyword: :?required_key/)
      end
    end

    describe "#extended_method" do
      it "拡張メソッドが正常に動作する" do
        result = child_with_extras_instance.extended_method(
          base_param: "基本",
          extra_param: "追加",
          another_param: "その他",
          yet_another: "さらに"
        )
        
        expect(result[:base_param]).to eq("基本")
        expect(result[:extra_param]).to eq("追加")
        expect(result[:remaining_params]).to eq({ another_param: "その他", yet_another: "さらに" })
        expect(result[:method_source]).to eq("ChildWithExtras")
      end
    end
  end

  describe "エラーケース" do
    it "必須キーワード引数が無いとエラーが発生する" do
      expect {
        base_instance.process_data(age: 25)
      }.to raise_error(ArgumentError, /missing keyword: :?name/)
    end

    it "未知の操作でエラーが発生する" do
      expect {
        base_instance.calculate(x: 5, operation: :divide)
      }.to raise_error(ArgumentError, "Unknown operation: divide")
    end
  end

  describe "ChildNoArgs" do
    describe "#flexible_method" do
      it "引数なしでflexible_methodをオーバーライドしても動作する" do
        result = child_no_args_instance.flexible_method
        expect(result[:received_keys]).to eq([])
        expect(result[:received_values]).to eq([])
        expect(result[:processed_by]).to eq("ChildNoArgs")
        expect(result[:note]).to eq("Child class with no arguments specified")
        expect(result[:class_name]).to eq("ChildNoArgs")
      end
    end

    describe "#custom_flexible" do
      it "子クラス独自のメソッドが動作する" do
        result = child_no_args_instance.custom_flexible
        expect(result[:message]).to eq("ChildNoArgs specific method")
        expect(result[:class_name]).to eq("ChildNoArgs")
      end
    end
  end

  describe "継承関係の確認" do
    it "ChildClassはBaseClassのサブクラスである" do
      expect(ChildClass.superclass).to eq(BaseClass)
      expect(child_instance).to be_a(BaseClass)
    end

    it "ChildWithExtrasはBaseClassのサブクラスである" do
      expect(ChildWithExtras.superclass).to eq(BaseClass)
      expect(child_with_extras_instance).to be_a(BaseClass)
    end

    it "ChildNoArgsはBaseClassのサブクラスである" do
      expect(ChildNoArgs.superclass).to eq(BaseClass)
      expect(child_no_args_instance).to be_a(BaseClass)
    end
  end
end