require "prism"

# 最初の数行だけ解析
source = <<~RUBY
  RSpec.describe 'assign_attributesの挙動', type: :model do
    describe 'has_one関連の自動保存の挙動' do
      it 'プロフィールが自動的に保存される' do
        # test code
      end
    end
  end
RUBY

tree = Prism.parse(source)

def print_ast(node, indent = 0)
  return unless node
  
  prefix = "  " * indent
  if node.respond_to?(:type)
    puts "#{prefix}#{node.type}"
    
    if node.type == :call_node
      puts "#{prefix}  method: #{node.name}"
      if node.arguments
        puts "#{prefix}  args: #{node.arguments.child_nodes.map { |arg| arg.type == :string_node ? arg.content : arg.type }}"
      end
    end
  end
  
  if node.respond_to?(:child_nodes)
    node.child_nodes.each do |child|
      print_ast(child, indent + 1)
    end
  end
end

print_ast(tree.value)