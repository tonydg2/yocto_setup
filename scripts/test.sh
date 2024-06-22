#!/bin/bash

cwd=$(pwd)

echo "$cwd"


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "$SCRIPT_DIR"


IMAGE_DIR="../../build/tmp/deploy/images/hw-u96/"
IMAGE_NAME="petalinux-image-minimal-hw-u96.wic"

IMAGE_ABS="$IMAGE_DIR$IMAGE_NAME"

echo "IMAGE_ABS=$IMAGE_ABS"
