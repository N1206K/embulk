export $(cat ~/embulk/.env | xargs)

 ~/.embulk/bin/embulk run ~/embulk/article_list/config_full_mysql_to_bigquery.yml.liquid --log /var/log/embulk/info.log
