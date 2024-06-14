# embulk

## 概要

emblukによるデータ移動


### ソース設置

/home/sample以下でgit clone で設置する。

```sh
$ cd embulk
```

### 環境変数

.envファイルを置いて以下を記述する。

```sh
export MYSQL_HOST=****
export MYSQL_USER=****
export MYSQL_PASSWORD=****

export BIGQUERY_PROJECT=****
export BIGQUERY_DATASET=****
export BIGQUERY_KEYFILE=****
```

## 実行

```sh
$ cd ~/embulk
```

### 差分実行(通常)

```sh
$ ./embulk.sh
```

### 全取得実行

```sh
$ ./embulk_full.sh
```

## cron設置

```sh
0 0 * * * /bin/bash -l /home/sample/embulk/embulk.sh 1>/dev/null 2>/var/log/embulk/error.log
```

## deploy

各環境でgit pullを行う。
