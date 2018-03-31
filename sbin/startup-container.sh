#!/usr/bin/env bash

source ./env-dockerfile.sh

VOLUME_HOST=~/data
VOLUME_CONTAINER=/data

echo ">> Begin --------------------------------"
echo "   IMAGE: ${NAME_IMAGE}"
echo "   TAG: ${NAME_TAG}"
echo ""
echo ">> VOLUME MOUNT -------------------------"
echo "   HOST: ${VOLUME_HOST}"
echo "   CONTAINER: ${VOLUME_CONTAINER}"
echo ""

if [ ! -d ${VOLUME_HOST} ]; then
  echo "[ERROR] ${VOLUME_HOST} is not exist!";
  echo "[ERROR] Check your path on your host.";
  echo "        ${VOLUME_HOST}";
  exit 0;
else 
  if [ ! -d ${VOLUME_HOST}/notebooks ]; then
    mkdir ${VOLUME_HOST}/notebooks
    echo ">> Created new path as on ${VOLUME_HOST}/notebooks"
  fi
fi

CMD="docker run -d \
-p 6006:6006 \
-p 8888:8888 \
-v ${VOLUME_HOST}:${VOLUME_CONTAINER} \
--name "${CONTAINER_NAME}" \
--rm \
${NAME_IMAGE}:${NAME_TAG}"
echo ${CMD}
exec ${CMD}