AWS.config({
  access_key_id: Rails.application.secrets.s3['access_key_id'],
  secret_access_key: Rails.application.secrets.s3['secret_access_key'],
  region: 'us-east-1'
})
