#!/bin/bash

start_time=$(date +%s)

CWD=$(pwd)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "SCRIPT_DIR = $SCRIPT_DIR"
echo "CWD = $CWD"
cd "$SCRIPT_DIR"


# Check if the device path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <device_path>"
    echo "Example: $0 /dev/sdg"
    exit 1
fi

DEVICE_PATH=$1

#IMAGE_PATH="../../build/tmp/deploy/images/myhardware-u96v2-zynqmp/u96-image-myhardware-u96v2-zynqmp.wic"
#IMAGE_PATH="../../build/tmp/deploy/images/hw-u96/u96-image-hw-u96.wic"
#IMAGE_PATH="../../build/tmp/deploy/images/hw-u96/petalinux-image-minimal-hw-u96.wic"
IMAGE_DIR="../../build/tmp/deploy/images/hw-u96"
IMAGE_NAME="petalinux-image-minimal-hw-u96.wic"

cd "$IMAGE_DIR"
IMAGE_PATH_ABS=$(pwd)
cd "$SCRIPT_DIR"
IMAGE_ABS=$IMAGE_PATH_ABS/$IMAGE_NAME

# Display block device list
echo "Current block devices:"
lsblk -d -o NAME,SIZE,TYPE,RM
echo ""

# Print the command to be executed
echo "The following command will be executed:"
echo "dd if=$IMAGE_ABS of=$DEVICE_PATH bs=1M; sync; eject $DEVICE_PATH"

# Ask for user confirmation
read -p "Is this correct? (y/n): " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    # Execute the commands
#    sudo dd if=$IMAGE_PATH of=$DEVICE_PATH bs=1M
    sudo dd if=$IMAGE_ABS of=$DEVICE_PATH bs=1M
    sync
    sudo eject $DEVICE_PATH
else
    echo "Operation canceled."
    exit 2
fi
end_time=$(date +%s)
duration=$((end_time - start_time))
minutes=$((duration / 60))
seconds=$((duration % 60))
echo "---------------------------------------------------------"
echo "DONE"
echo "${minutes}m : ${seconds}s"
echo "---------------------------------------------------------"
cd "$CWD"