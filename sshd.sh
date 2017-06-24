#!/bin/bash
IMGVERSION=$(head -n 1 .IMGVERSION)
IMGVERSION=${IMGVERSION:-"latest"}
IMGNAME=$(head -n 1 .IMGNAME)
ENVBASH=$1
ENVBASH=${ENVBASH:-"sh"}
docker stop sshd
docker rm sshd
docker run --name sshd -d \
  -p 2200:22 \
  "$IMGNAME:$IMGVERSION"
