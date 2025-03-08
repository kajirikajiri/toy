# Docker Composeを使用したFlaskサーバー

このプロジェクトは、Docker Composeを使用してシンプルなFlaskサーバーをセットアップします。サーバーにはヘルスチェックエンドポイントが含まれています。

## 前提条件

1. ffmpegがインストールされていること
2. python3 -m venv venv
3. source venv/bin/activate
4. pip install -r requirements.txt
5. python3 app.py
6. Flaskサーバーは `http://localhost:4673` で実行されます。
7. curl -X POST http://localhost:4673/transcribe -F "file=@/Users/User/Downloads/test.m4a"
8. Macのショートカットの場合は、オーディオを録音と内容を取得を使う。POSTリクエストで本文を要求「フォーム」キーfile、種類はファイル、値は録音したオーディオファイルを選択する。
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