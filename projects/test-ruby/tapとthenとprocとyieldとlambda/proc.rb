# Procオブジェクトはcallできる。
# ダイナミックローカル変数はProcローカルの変数として扱える。
var = 1
f = Proc.new { var }
var = 2
p f.call # 2

# nextで手続きを中断して値を返せる
# breakやreturnではない。
f = Proc.new do
  next 3
  4 # 到達しない
end
p f.call

# Proc.newでreturnすると、手続きオブジェクトを囲むメソッドを抜ける
def method
  f = Proc.new { return :proc }
  f.call
  return :method
end
p method

# lambdaでは手続きオブジェクト自身を抜ける
def method
  f = lambda { return :lambda }
  f.call
  return :method
end
p method

# lambdaのショートハンドは->
def method
  (-> { return :lambda }).call
end
p method

# &:はSymbol.to_proc。lambdaを返す
p :to_i.to_proc.lambda?

# メソッドに&シンボルを渡すと、Symbol.to_procが呼ばれ、Procオブジェクトになり、ブロックが渡される
p [1,2].each(&:to_s)

# Kernel.procはProc.newと一緒
f = proc { 5 }
p f.call

# blockを渡さずにyieldを呼ぶと、LocalJumpErrorが発生する
def method
  yield
end
method rescue p $!

# yieldはblockつきメソッドに渡されたblockを評価する
def method # block付きメソッド
  yield if block_given? # blockが渡されてたら使うようにもできる
end
f = proc { 6 }
# Procオブジェクトをブロックにして渡す
puts method(&f)
# ブロックを渡す
puts method { 7 }

# ブロックをProcオブジェクトに変換できる。
def method(&f) # &fを定義するだけもできる
  yield
end
f = proc { 8 }
puts method(&f)

def method(&f) # &をつけて、ブロックをProcオブジェクトとして受けとり、callすることもできる。
  f.call
end
f = proc { 9 }
puts method(&f)

# lambdaはよりメソッドに近い設定になっており、引数の数が違うとエラーになる
f = lambda { 10 } # 引数なしのlambda
f.call(11) rescue p $! #<ArgumentError: wrong number of arguments (given 1, expected 0)>

# ブロック付きメソッド呼び出しで、yieldが複数あればその分呼ばれる
def method
  yield 1
  yield 2
  yield 3
end
method { p it }

# Array#eachの類似品
def iich(arr)
  idx = 0
  while idx < arr.size
    yield arr[idx]
    idx += 1
  end
end

iich(['a', 'b', 'c']) do
  p it
end