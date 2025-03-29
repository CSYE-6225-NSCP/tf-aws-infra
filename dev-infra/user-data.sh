#!/bin/bash
echo "Hello World!"

sudo echo "DB_HOST=${DB_HOST}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_PORT=3306" | sudo tee -a /opt/webapp/.env

sudo echo "DB_USER=${DB_USER}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_PASSWORD=${DB_PASSWORD}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_NAME=${DB_NAME}" | sudo tee -a /opt/webapp/.env

sudo echo "SERVER_PORT=${SERVER_PORT}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_DIALECT=${DB_DIALECT}" | sudo tee -a /opt/webapp/.env

sudo echo "S3_BUCKET_NAME=${S3_BUCKET_NAME}" | sudo tee -a /opt/webapp/.env

sudo echo "AWS_REGION=${AWS_REGION}" | sudo tee -a /opt/webapp/.env

sudo echo "DB_LOGGING=false" | sudo tee -a /opt/webapp/.env

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/cloudwatch-config.json -s