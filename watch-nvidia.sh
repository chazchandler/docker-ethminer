#!/usr/bin/env bash

CID=$(docker ps | grep chaznet/eth-cuda-miner | awk '{print $1;}')
watch -c -n 5 "nvidia-smi ; echo -n '# accepted: ' ; docker logs $CID | grep accepted | wc -l ; docker logs --tail 20 $CID | cut -d \[ -f 1-15"
