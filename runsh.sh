#!/bin/bash
IMGVERSION=$(head -n 1 .IMGVERSION)
IMGVERSION=${IMGVERSION:-"latest"}
IMGNAME=$(head -n 1 .IMGNAME)
ENVBASH=$1
ENVBASH=${ENVBASH:-"sh"}
docker run --rm -ti \
  -v $(pwd)/src/startsshd.sh:/opt/startsshd.sh \
  "$IMGNAME:$IMGVERSION" $ENVBASH ${@:2}
