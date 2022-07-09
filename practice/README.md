# Set properties in profile configuration
gcloud init/gcloud config configurations create <configuration_name>
gcloud info
# List configurations
```aidl
 ll ~/.config/gcloud/configurations 
total 16
-rw-r--r--  1 lamhoang  staff  136 Jun 20 13:28 config_default
-rw-r--r--  1 lamhoang  staff  121 Jun 17 11:04 config_lamhoang

(base) lamhoang@VNHOCLT0004 practice % gcloud config configurations list
NAME      IS_ACTIVE  ACCOUNT                 PROJECT                  COMPUTE_DEFAULT_ZONE  COMPUTE_DEFAULT_REGION
default   True       lam@trustingsocial.com  prj-ts-p-etl-infra-45d9  asia-southeast1-a     asia-southeast1
lamhoang  False      admin@ai4u.io           fb-crawler-331309        asia-southeast1-a     asia-southeast1

```