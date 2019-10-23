#!/bin/sh
echo "Init localstack s3"
awslocal s3 mb s3://whitelist-bucket
awslocal s3 mb s3://certs-bucket
awslocal s3 cp /tmp/localstack/whitelist-bucket/clients.conf s3://whitelist-bucket
awslocal s3 sync /tmp/localstack/certs-bucket/ s3://certs-bucket/
