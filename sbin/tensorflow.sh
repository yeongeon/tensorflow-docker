#!/usr/bin/env bash

source ./env-dockerfile.sh

echo ">> Begin --------------------------------"
echo "   CONTAINER_NAME: ${CONTAINER_NAME}"
echo ""

CMD="docker exec -it ${CONTAINER_NAME} /bin/bash -l"
echo ${CMD}
exec ${CMD}