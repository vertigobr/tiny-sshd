#!/bin/bash
[ -f ./setenv.sh ] && source ./setenv.sh
IMGVERSION=$(head -n 1 .IMGVERSION)
IMGVERSION=${IMGVERSION:-"latest"}
IMGNAME=$(head -n 1 .IMGNAME)
echo "Building $IMGNAME:$IMGVERSION"
[[ ! -z "$ARGPROXY" ]] && echo "ARGPROXY=$ARGPROXY"
# docker build $ARGPROXY \
#   -t "$IMGNAME:$IMGVERSION" .
docker buildx build --push \
  --platform linux/amd64,linux/arm64 \
  --tag "$IMGNAME:$IMGVERSION" .
echo "Done!"
