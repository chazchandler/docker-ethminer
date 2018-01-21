#/usr/bin/env bash

set -euo pipefail

. ./env.sh

export REVISION="$(date +'%Y-%m-%d')"
TAG_L0="${CUDA_VERSION}-${ETHMINER_VERSION}-${REVISION}"
TAG_L1="${CUDA_VERSION}-${ETHMINER_VERSION_XY}-${REVISION}"
#TAG_L2="${CUDA_VERSION}-${ETHMINER_VERSION}-${REVISION}"

docker-compose build

docker tag ${IMAGE_NAME}:${TAG_L0} ${IMAGE_NAME}:${TAG_L1}
#docker tag ${IMAGE_NAME}:${TAG_L0} ${IMAGE_NAME}:${TAG_L2}
