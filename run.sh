#/usr/bin/env bash

set -euo pipefail

. ./env.sh

REVISION=${LAST_REVISION}

if [ -z "$REVISION" ]; then
  echo "WARNING: no built container image exists, building now..."
  ./build.sh
fi

sudo ./nvidia-overclock.sh
TAG="${CUDA_VERSION}-${ETHMINER_VERSION}-${REVISION}"
IMAGE="chaznet/eth-cuda-miner:${TAG}"
WORKER="$(hostname -s)"
ADDRESS="0x43b21d49E2049CC93E072c6cA381d2E35d7b60be"
POOL="eth-us-east1.nanopool.org:9999"
ACCOUNT="zuluchas@gmail.com"
CID=$(nvidia-docker run -itd ${IMAGE} -S ${POOL} -O ${ADDRESS}.${WORKER}/${ACCOUNT})
echo "CID=${CID}"
./watch-nvidia.sh
