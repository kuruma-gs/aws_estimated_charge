aws_estimated_charge
====================
- CloudWatchからAWSの料金を取得して、Chatworkに通知する
- 以下の設定ファイルを追加すること

- config.yml    
```
aws:
  access_key_id: 'xxxxxxxxxxxxxxx'
  secret_access_key: 'xxxxxxxxxxxxxxxxxxxxxx'
  region: 'us-east-1'

chatwork:
  api_key: xxxxxxxxxxxxxxxxx
  room_id: xxxxxxxxxxxxxx
```
