# Docker Composeを使用したFlaskサーバー

このプロジェクトは、Docker Composeを使用してシンプルなFlaskサーバーをセットアップします。サーバーにはヘルスチェックエンドポイントが含まれています。

## 前提条件

- Docker
- Docker Compose

## セットアップ

1. リポジトリをクローンします:
    ```sh
    git clone https://github.com/kajirikajiri/toy.git
    cd toy/whisper
    ```

2. Dockerコンテナをビルドして起動します:
    ```sh
    docker-compose up --build
    ```

3. Flaskサーバーは `http://localhost:4673` で実行されます。

## ヘルスチェック

サーバーのヘルスをチェックするには、次のエンドポイントにアクセスします:
```
http://localhost:4673/health
```

このエンドポイントは `OK` とステータスコード `200` を返します。

## サーバーの停止

サーバーを停止するには、次のコマンドを実行します:
```sh
docker-compose down
```