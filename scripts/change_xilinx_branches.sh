#!/bin/bash

CWD=$(pwd)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

BRANCH="rel-v2023.2"

cd ../../sources/meta-openamp
git checkout $BRANCH;git pull;git checkout .;
cd ../meta-openembedded
git checkout $BRANCH;git pull;git checkout .;
cd ../meta-petalinux
git checkout $BRANCH;git pull;git checkout .;
cd ../meta-qt5
git checkout $BRANCH;git pull;git checkout .;
cd ../meta-ros
git checkout $BRANCH;git pull;git checkout .;
cd ../meta-virtualization
git checkout $BRANCH;git pull;git checkout .;
cd ../meta-xilinx
git checkout $BRANCH;git pull;git checkout .;
cd ../meta-xilinx-tools
git checkout $BRANCH;git pull;git checkout .;
cd ../poky
git checkout $BRANCH;git pull;git checkout .;

cd $CWD
