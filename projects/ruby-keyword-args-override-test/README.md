# Rubyキーワード引数メソッドオーバーライド動作検証

Rubyにおけるキーワード引数を使ったメソッドのオーバーライド時の動作を検証するプロジェクトです。

## 検証内容

### 1. 基本的なキーワード引数オーバーライド
- デフォルト値の変更
- 親クラスメソッドの`super`呼び出し
- キーワード引数の型安全性

### 2. 拡張パターン
- 新しいキーワード引数の追加
- `**kwargs`を使った可変キーワード引数
- 必須キーワード引数とオプショナル引数の組み合わせ

### 3. エラーハンドリング
- 必須キーワード引数の不足
- 未知のパラメータ処理
- 型不整合の検証

## プロジェクト構造

```
ruby-keyword-args-override-test/
├── Gemfile                          # 依存関係管理
├── README.md                        # このファイル
├── lib/
│   ├── base_class.rb               # 基底クラス
│   ├── child_class.rb              # 標準的なオーバーライド
│   └── child_with_extras.rb        # 拡張オーバーライド
└── spec/
    ├── spec_helper.rb              # RSpec設定
    └── keyword_args_override_spec.rb # テストケース
```

## クラス設計

### BaseClass
- `process_data(name:, age: 20, city: "Tokyo")` - 基本データ処理
- `calculate(x:, y: 10, operation: :add)` - 計算処理
- `flexible_method(**kwargs)` - 可変キーワード引数

### ChildClass < BaseClass
- デフォルト値を変更したオーバーライド
- `super`を使った親クラス機能の拡張

### ChildWithExtras < BaseClass  
- 新しいキーワード引数の追加
- `**kwargs`パターンの活用
- より複雑なパラメータ処理

## セットアップと実行

### 1. 依存関係のインストール
```bash
cd projects/ruby-keyword-args-override-test
bundle install
```

### 2. テスト実行
```bash
# 全テスト実行
bundle exec rspec

# 詳細出力
bundle exec rspec --format documentation

# 特定のテストファイルのみ
bundle exec rspec spec/keyword_args_override_spec.rb
```

### 3. 個別クラスの動作確認
```bash
# Rubyインタラクティブシェルで確認
ruby -I lib -r base_class -r child_class -r child_with_extras
```

## 検証ポイント

### 1. デフォルト値の継承・変更
```ruby
# BaseClass: age: 20, city: "Tokyo"  
# ChildClass: age: 25, city: "Osaka"
# ChildWithExtras: age: 30, city: "Kyoto"
```

### 2. 新規キーワード引数の追加
```ruby
# ChildWithExtrasでは country: "Japan" が追加される
result = instance.process_data(name: "田中", country: "Japan")
```

### 3. 可変キーワード引数の処理
```ruby
# **extra_params パターン
result = instance.process_data(name: "田中", hobby: "読書", job: "エンジニア")
```

### 4. super呼び出しでの引数伝播
```ruby
# 子クラスから親クラスへの適切な引数渡し
def process_data(name:, age: 25, city: "Osaka")
  result = super  # 正しい引数が親クラスに渡される
  # 追加処理...
end
```

## 期待される学習効果

1. **キーワード引数の継承挙動の理解**
2. **superメソッドでの引数伝播メカニズム**
3. **可変キーワード引数(**kwargs)の活用パターン**
4. **メソッドオーバーライド時の設計パターン**
5. **Rubyの引数処理における型安全性**

## 動作確認済み環境
- Ruby 3.0以上
- RSpec 3.12以上