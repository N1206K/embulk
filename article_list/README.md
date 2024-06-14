# article_list

mysqlのarticlesテーブルから必要なデータをBigQueryへ転送する

## ファイル

|  ファイル  |  説明  |
| ---- | ---- |
|  config_diff_mysql_to_bigquery.yml.liquid  |  デイリーで動かすembulk設定  |
|  config_full_mysql_to_bigquery.yml.liquid  |  初回実行用のembulk設定  |
|  merge.sh  |  差分データをマージする処理  |

## 内容

mysqlのarticlesテーブルの内容をBigQueryのsample_article_list_yyyymmdd (yyyymmdd部分はpartition用)に保存する。
差分のみのテーブルを作成するために、少々複雑な方法を取っている。

### 差分更新

以下のフローで差分更新データによるテーブル作成を行っている。

1. embulkにより前日0:00〜23:59までのデータを取得し、sample_temp_article_listsテーブルに保存する.
2. 前日のデータテーブル(例：sample_article_lists_20220101) とsample_temp_article_listsをUNION ALLで混ぜた結果を当日のデータテーブル　(例：sample_article_lists_20220102)として作成する.
