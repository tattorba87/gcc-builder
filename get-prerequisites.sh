#!/bin/bash
##
##  Script: configure-gcc.sh
##
##  This second-level script gets prerequisites for GCC,
##  needed to build it.
##
##- Make sure we're in the same directory as this script.
##
export TOP_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $TOP_DIR

##- Get the GCC-related variables for this build.
##
source ./gcc-build-vars.sh

##- Run the GCC configure script using our customizations.
##
cd $GCC_SRC_DIR
echo -n "Downloading prerequisites..."

./contrib/download_prerequisites
