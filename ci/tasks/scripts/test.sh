#!/bin/bash

set -e -u -o pipefail

./src/ci/tasks/scripts/with-docker.sh

cp "frontend" "src/.frontend"
cp "authentication-api" "src/.authentication-api"
cp "logging-api" "src/.logging-api"

workspace_dir="${PWD}"
cd src

make test

cd "${workspace_dir}"
