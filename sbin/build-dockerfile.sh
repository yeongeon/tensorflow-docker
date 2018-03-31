#!/usr/bin/env bash

source ./env-dockerfile.sh

cd ../.

CMD="docker build -t ${NAME_IMAGE}:${NAME_TAG} ."
echo ${CMD}
exec ${CMD}