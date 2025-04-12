#!/bin/bash
echo "Hello World!"

# shellcheck disable=SC2154

aws secretsmanager get-secret-value \
  --secret-id "${secret_name}" \
  --region us-east-1 \
  --query SecretString \
  --output text | jq -r 'to_entries[] | "\(.key)=\(.value)"' | sudo tee /opt/webapp/.env

sudo echo "DB_NAME=${DB_NAME}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_HOST=${DB_HOST}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_USER=${DB_USER}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_PORT=${DB_PORT}" | sudo tee -a /opt/webapp/.env

sudo echo "SERVER_PORT=${SERVER_PORT}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_DIALECT=${DB_DIALECT}" | sudo tee -a /opt/webapp/.env

sudo echo "S3_BUCKET_NAME=${S3_BUCKET_NAME}" | sudo tee -a /opt/webapp/.env

sudo echo "AWS_REGION=${AWS_REGION}" | sudo tee -a /opt/webapp/.env

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cloudWatch-config.json -s

