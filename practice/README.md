# Set properties in profile configuration
gcloud init/gcloud config configurations create <configuration_name>
gcloud info
# List configurations
```shell script
ll ~/.config/gcloud/configurations 
total 16
-rw-r--r--  1 lamhoang  staff  136 Jun 20 13:28 config_default
-rw-r--r--  1 lamhoang  staff  121 Jun 17 11:04 config_lamhoang

(base) lamhoang@VNHOCLT0004 practice % gcloud config configurations list
NAME      IS_ACTIVE  ACCOUNT                 PROJECT                  COMPUTE_DEFAULT_ZONE  COMPUTE_DEFAULT_REGION
default   True       lam@trustingsocial.com  prj-ts-p-etl-infra-45d9  asia-southeast1-a     asia-southeast1
lamhoang  False      admin@ai4u.io           fb-crawler-331309        asia-southeast1-a     asia-southeast1

gcloud config configurations activate my-config
```

```shell script
bq show --schema --format=prettyjson prj-ts-p-etl-infra-45d9:v2_proxy.customer_history > schema.json
bq mk --table --description [DESCRIPTION] [PROJECT_ID]:[DATASET].[TABLE] ./schema.json

-- For RECORD type: work only for MODE NULLABLE
bq update data-engineering-230006:lamhoang_cdc.application_metadata_changelog /tmp/schema.json
```