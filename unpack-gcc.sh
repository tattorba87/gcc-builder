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
    tar xf ./tarballs/$GCC_TARBALL

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

##- Apply GCC patches.
##
echo -n "Checking for GCC build directory $GCC_BLD_DIR... "
if [ ! -e $GCC_BLD_DIR ]
then
    echo ""
    echo "Making new build directory..."
    mkdir -v $GCC_BLD_DIR
else
    echo " already exists"
fi

cd $GCC_SRC_DIR

echo -n "Checking for existence of custom GCC fixes... "
if [ ! -e custom_fixes_done ]
then
    echo ""
    echo "Applying custom fixes..."

    if [ ! -e config.guess-orig ]
    then
        echo "Applying config.guess customization..."
        cp -p config.guess config.guess-orig
        cp ../custom-config-guess.sh ./config.guess
    fi

    touch custom_fixes_done
else
    echo " already applied"
fi

echo "GCC unpacking completed!"