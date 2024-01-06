SQL 第２版 ゼロからはじめるデータベース操作

.gitignoreをみて、Sampleディレクトリをコピーしてくる。

\echo :HISTSIZE;
psql実行中にHISTSIZEを確認できる。:HISTSIZEだけでも3000が確認できるが実行エラーが発生する。

.psql_historyをローカルに同期。
何を実行したかわかるようにした。

psqlコマンドに-dをつけるとdatabaseにログインできる。

psql内では\i file.sql でsqlファイルを実行できる
またはpsql -d database_name -U user_name -f file.sql

ALTER TABLEのADD COLUMNのCOLUMNはoptional
https://www.postgresql.org/docs/current/sql-altertable.html
> ADD [ COLUMN ] [ IF NOT EXISTS ] column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]

\d+ table_name;でカラムを確認できる
