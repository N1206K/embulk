export $(cat ~/embulk/.env | xargs)

gcloud auth activate-service-account \
sample-analytics@sample-app.iam.gserviceaccount.com \
--key-file /home/sample/sample-app-88a3978e76db.json \
--project sample-app

DAY_BEFORE_YESTERDAY=`date -d '2 day ago' "+%Y%m%d"`
YESTERDAY=`date -d '1 day ago' "+%Y%m%d"`

SQL=$(cat << EOS
SELECT
* EXCEPT(rn)
FROM (
        SELECT
                *,
                row_number() over (PARTITION BY article_id ORDER BY updated_at DESC) AS rn
        FROM (
                SELECT * FROM ${BIGQUERY_DATASET}.sample_temp_article_list
                UNION ALL
                SELECT * FROM ${BIGQUERY_DATASET}.sample_article_list_${DAY_BEFORE_YESTERDAY}
        )
)
WHERE rn = 1
EOS
)

bq query --batch  \
--project_id ${BIGQUERY_PROJECT} \
--max_rows 1 \
--replace \
--allow_large_results \
--use_legacy_sql=false \
--destination_table ${BIGQUERY_PROJECT}:${BIGQUERY_DATASET}.sample_article_list_${YESTERDAY} \
"${SQL}"