export CUDA_VERSION="9.1"
export ETHMINER_VERSION="0.12.0"

export IMAGE_NAME="chaznet/eth-cuda-miner"
export ETHMINER_VERSION_XY="$(echo ${ETHMINER_VERSION} | cut -d. -f 1-2)"
#export ETHMINER_VERSION_X="$(echo ${ETHMINER_VERSION} | cut -d. -f 1)"
export LAST_ETHMINER_TAG="$(docker image ls | grep ${IMAGE_NAME} | grep ${CUDA_VERSION}-${ETHMINER_VERSION} | awk '{print $2}' | sort | tail -n1)"
export LAST_REVISION="${LAST_ETHMINER_TAG#$CUDA_VERSION-$ETHMINER_VERSION-}"
