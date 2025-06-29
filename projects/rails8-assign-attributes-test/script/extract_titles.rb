# 概要:
# このスクリプトは、RSpecテストファイルから、describeやcontext、it等の主要なテスト記述用キーワード
# の第1引数（主にテストの説明文）を階層構造として抽出し、スペース区切りで出力します。

require "prism"

# RSpecで対象とするキーワードの一覧
RSPEC_KEYWORDS = %w[
  describe context feature shared_examples shared_context it specify scenario example
]

# 実際にテストを実行するキーワード（これらは出力対象になる）
TEST_EXECUTION_KEYWORDS = %w[it specify scenario example]

# テストグループを作るキーワード（これらは階層を作る）
GROUP_KEYWORDS = %w[describe context feature shared_examples shared_context]

# PrismのASTノードを再帰的に走査して、RSpec各キーワードの第1引数(文字列)を階層付きで抽出する
def extract_titles(node, ancestors = [], &block)
  return unless node

  case node.type
  when :call_node
    method_name = node.name.to_s
    
    # RSpecのキーワードにマッチした場合
    if RSPEC_KEYWORDS.include?(method_name)
      first_arg = node.arguments&.child_nodes&.first
      
      # 第1引数が文字列リテラルの場合のみ
      if first_arg && first_arg.type == :string_node
        str = first_arg.content
        new_ancestors = ancestors + [str]
        
        # テスト実行キーワードの場合は出力
        if TEST_EXECUTION_KEYWORDS.include?(method_name)
          yield new_ancestors
        end
        
        # ブロックを持つ場合は、ブロック本体も新しい階層で再帰的にたどる
        block_node = node.child_nodes.find { |child| child&.type == :block_node }
        if block_node
          if GROUP_KEYWORDS.include?(method_name)
            # グループキーワード（describe, context等）の場合は新しい階層で処理
            extract_titles(block_node, new_ancestors, &block)
          elsif TEST_EXECUTION_KEYWORDS.include?(method_name)
            # テスト実行キーワード（it等）の場合も階層を保持して処理
            extract_titles(block_node, new_ancestors, &block)
          end
        end
        
        # 階層処理が完了した場合はreturn
        return if block_node
      end
    end
    
    # 子ノードを処理
    node.child_nodes.each do |child|
      extract_titles(child, ancestors, &block)
    end
    
  else
    # 他のノードタイプは子ノードをすべて処理
    node.child_nodes.each do |child|
      extract_titles(child, ancestors, &block)
    end
  end
end

# メイン処理
path = ARGV[0] || "spec/models/assign_attributes_spec.rb"
source = File.read(path)
tree = Prism.parse(source)

# 階層ごとにタイトルを出力
extract_titles(tree.value) do |titles|
  puts titles.join(" ")
end