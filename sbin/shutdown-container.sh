#!/usr/bin/env bash

source ./env-dockerfile.sh

echo ">> Begin --------------------------------"
echo "   CONTAINER_NAME: ${CONTAINER_NAME}"
echo ""

CMD="docker rm -f ${CONTAINER_NAME}"
echo ${CMD}
exec ${CMD}