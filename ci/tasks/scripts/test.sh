#!/bin/bash

set -e -u -o pipefail

./src/ci/tasks/scripts/with-docker.sh

cp -r "frontend" "src/.frontend"
cp -r "authentication-api" "src/.authentication-api"
cp -r "logging-api" "src/.logging-api"

workspace_dir="${PWD}"
cd src

make test

cd "${workspace_dir}"
