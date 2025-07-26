# RubyのObject#tapとObject#then
- Object#tapはselfを引数としてブロックを評価しselfを返します。
- #thenはselfを引数としてブロックを評価しブロックの結果を返します。
- selfは特定のコンテキストにおける自身を表すオブジェクトである擬似変数です。
- メソッドは何らかのオブジェクトに対して呼び出されるが、この時、そのオブジェクトのことをレシーバーと呼びます。
- ブロックはオブジェクトではない。
- メソッドの引数にブロックを一つ渡すことができる。
- ブロックはオブジェクトではないが、Procオブジェクトとしてオブジェクト化することができる。

# 関係薄いが学び
- https://docs.ruby-lang.org/ja/latest/doc/glossary.html
  - Ruby言語のキーワードについて辞書のように使うことができる。例えばselfで検索するとレシーバーが出てくるような感じで使える。

# Rubyファイルの動かし方
```sh
docker run --rm -it -v $(pwd):/_a -w /_a ruby:slim ruby {relative_path}
```