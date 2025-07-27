# Elasticsearch

## 構成
クラスター has many ノード has many シャード
インデックスは論理的なもので、シャードが物理的なもの。
ノード has many ロール。マスターロールは3ノード以上設定。2ノードだと、1ノード死んだときにSplit Brainが発生。
ロールは、マスター、データ、インゲスト、コーディネーティング等。

## 参考
https://dev.classmethod.jp/articles/elasticsearch-getting-started-06/
https://qiita.com/kotarella1110/items/5b90bd9166dd44da49de
https://dev.classmethod.jp/articles/elasticsearch-starter4/
https://engineering.mercari.com/blog/entry/20220311-97aec2a2f8/
https://www.elastic.co/jp/blog/how-to-configure-elasticsearch-cluster-better