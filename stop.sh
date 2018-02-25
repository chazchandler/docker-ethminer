#!/usr/bin/env bash

CID=$(docker ps | grep chaznet/eth-cuda-miner | awk '{print $1;}')
docker stop $CID
