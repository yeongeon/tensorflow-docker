#!/usr/bin/env bash

source ./env-dockerfile.sh

function help() {
   echo 'usage : startup-container.sh [--hub] [-h|--help]'
   echo ' --hub'
   echo '       To use image in the docker hub.'
   echo ' -h, --help'
   echo '       The help'
}

USE_HUB=false
while [ $# -gt 0 ]
do
  case "$1" in
    --hub)
      shift; USE_HUB=true;;
    -h)
      help; exit 0;;
    --help)
      help; exit 0;;
    -*)
      echo "unrecognized option: $1"; exit 0;;
    *)
      break;
      ;;
  esac
  shift
done

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
echo ">> JUPYTER PASSWORD -------------------------"
echo "   JPT_PASSWORD: ${JPT_PASSWORD}"
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

if ($USE_HUB); then
  NAME_IMAGE="${HUB_ACCOUNT}/${NAME_IMAGE}"	
  echo ">> Using ${NAME_IMAGE} in docker hub."
fi

CMD="docker run -d \
-p 6006:6006 \
-p 8888:8888 \
-p 8182:8182 \
-e JPT_PASSWORD=${JPT_PASSWORD} \
-v ${VOLUME_HOST}:${VOLUME_CONTAINER} \
--name "${CONTAINER_NAME}" \
--rm \
${NAME_IMAGE}:${NAME_TAG} "
echo ${CMD}
exec ${CMD}
