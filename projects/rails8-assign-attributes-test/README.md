# テストの構造を出力
```sh
docker compose run --rm app bin/rails runner script/extract_titles.rb
```

# TODO
 spec/models/assign_attributes_spec.rbは各モデルへの興味は少ない。
どちらかというと、関連付けに興味がある。