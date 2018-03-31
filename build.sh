#!/usr/bin/env bash

source ./sbin/env-dockerfile.sh

CMD="docker build \
-t ${NAME_IMAGE}:${NAME_TAG} \
. "

echo ${CMD}
exec ${CMD}