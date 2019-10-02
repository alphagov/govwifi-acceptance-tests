#!/bin/sh
echo "Init localstack s3"
awslocal s3 mb s3://test-bucket
awslocal s3 cp /tmp/localstack/clients.conf s3://test-bucket
awslocal s3 sync /tmp/localstack/.certs s3://test-bucket
touch /tmp/localstack/comodoCA.pem
awslocal s3 cp /tmp/localstack/comodoCA.pem s3://test-bucket
