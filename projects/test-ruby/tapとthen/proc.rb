# procはcallできる。
# ダイナミックローカル変数はprocのローカル変数として扱える。
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

# Kernel.procはProc.newと一緒
f = proc { 5 }
p f.call

# blockを渡すならyieldが使える
# procに&をつけてblockにできる
# yieldはblockつきメソッドに渡されたblockを評価する
def method # block付きメソッド
  yield if block_given? # blockが渡されてたら使うようにもできる
end
f = proc { 6 }
puts method(&f)
puts method { 7 }

# blockをprocに変換できる。
def method(&f) # &fを定義だけすることもできる
  yield
end
f = proc { 8 }
puts method(&f)

def method(&f) # &をつけて、blockをprocとして受けとり、callすることもできる。
  f.call
end
f = proc { 9 }
puts method(&f)

# lambdaはよりメソッドに近い設定になっており、引数の数が違うとエラーになる
f = lambda { 10 } # 引数なしのlambda
f.call(11) rescue p $! #<ArgumentError: wrong number of arguments (given 1, expected 0)>

