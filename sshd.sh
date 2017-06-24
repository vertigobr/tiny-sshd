#!/bin/bash
IMGVERSION=$(head -n 1 .IMGVERSION)
IMGVERSION=${IMGVERSION:-"latest"}
IMGNAME=$(head -n 1 .IMGNAME)
ENVBASH=$1
ENVBASH=${ENVBASH:-"sh"}
PUBLICKEY=`cat ~/.ssh/id_rsa.pub`
docker stop sshd
docker rm sshd
docker run --name sshd -d \
  -p 2200:22 \
  -e "PUBLICKEY=$PUBLICKEY" \
  -e "KEYONLY=true" \
  -e "HOSTCHECK=false" \
  "$IMGNAME:$IMGVERSION"
