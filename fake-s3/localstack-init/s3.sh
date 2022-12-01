#!/bin/sh
echo "Init localstack s3"
awslocal s3 mb s3://allowlist-bucket
awslocal s3 mb s3://certs-bucket
awslocal s3 cp /var/lib/localstack/allowlist-bucket/clients.conf s3://allowlist-bucket
awslocal s3 sync /var/lib/localstack/certs-bucket/ s3://certs-bucket/
