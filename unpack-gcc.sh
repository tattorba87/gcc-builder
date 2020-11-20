#!/bin/bash
##
##  Script: unpack-gcc.sh
##
##  This second-level script unpacks the source tarballs, places everything
##  in the correct locations, and the performs any required patching.
##
##- Make sure we're in the same directory as this script.
##
export TOP_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $TOP_DIR

##- Get the GCC-related variables for this build.
##
source ./gcc-build-vars.sh

echo "Checking for required tarballs... "
for I in $ALL_TARBALLS
do
    if [ ! -e ./tarballs/$I ]
    then
        echo "Missing required tarball $I...   exiting build..."
        exit
    fi
done

##- Unpack all tarballs.
##
echo -n "Checking for source directory $GCC_SRC_DIR..."
if [ ! -e $GCC_SRC_DIR ]
then
    echo ""
    echo "Making new source directory..."
    echo "Upacking GCC tarball $GCC_TARBALL..."
    tar -xzf ./tarballs/$GCC_TARBALL

    if [ "$GCC_PLATFORM" = "Linux" ]
    then
        echo "Not using custom bunutils, GMP, MPC or MPFR"
    else
        echo "Unknown build platform!"
        exit 1
    fi
else
    echo " already exists"
fi

echo "GCC unpacking completed!"