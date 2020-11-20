#!/bin/bash
##
##  Script: configure-gcc.sh
##
##  This second-level script configures GCC, and anything else that is
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
cd $GCC_BLD_DIR
echo -n "Checking for configuration log in $GCC_BLD_DIR..."

if [ ! -e config.log ]
then
    echo ""
    echo "Running configure from $GCC_SRC_DIR... "
    echo ""

    if [ "$GCC_PLATFORM" == "Linux" ]
    then
        $GCC_SRC_DIR/configure -v               \
            --with-pkgversion="$GCC_PKG_NAME"   \
            --prefix=$GCC_INSTALL_PREFIX        \
            --program-suffix=$GCC_EXE_SUFFIX    \
            --enable-languages=c,c++,fortran    \
            --disable-multilib                  \
    else
        echo "Unknown build platform! Platform = $GCC_PLATFORM!"
        exit 1
    fi

    echo "GCC configuration completed!"
    echo ""
else
    echo " found"
    echo "GCC configure has already been run"
fi
