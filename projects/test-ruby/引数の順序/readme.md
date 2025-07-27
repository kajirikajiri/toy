# Rubyのメソッドの引数の記載順序

https://docs.ruby-lang.org/ja/latest/method/Method/i/parameters.html

この順で定義出来るようだが、公式に言及はない

1. 必須引数
2. デフォルト値が指定されたオプショナルな引数
3. *で指定された残りすべての引数
4. 必須のキーワード引数
5. デフォルト値が指定されたオプショナルなキーワード引数
6. **で指定された残りのキーワード引数
7. &で指定されたブロック引数

## 補足
Rubyファイルの動かし方
```sh
docker run --rm -it -v $(pwd):/_a -w /_a ruby:slim ruby {relative_path}
```
