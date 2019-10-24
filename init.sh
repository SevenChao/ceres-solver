#!/usr/bin/env bash

# Save script's current directory
DIR=$(pwd)

set -e
set -u
set -x


echo "############################"
echo "# install ceres "
echo "############################"
echo ""
echo "ceres-solver.org"
echo ""
echo "Ubuntu 16.04 bugs:"
echo "https://bugs.launchpad.net/ubuntu/+source/ceres-solver/+bug/1596296"
echo "https://bugs.launchpad.net/ubuntu/+source/ceres-solver/+bug/1595692"
echo "INCLUDES HACK TO GET AROUND missing package files IN UBUNTU 16.04"


. /etc/lsb-release # get ubuntu version number

# only install
if [ "$DISTRIB_RELEASE" = "16.04" ]; then

    # CMake
    sudo apt-get install -y cmake
    # google-glog + gflags
    sudo apt-get install -y libgoogle-glog-dev
    # BLAS & LAPACK
    sudo apt-get install -y libatlas-base-dev
    # Eigen3
    sudo apt-get install -y libeigen3-dev
    # SuiteSparse and CXSparse (optional)
    # - If you want to build Ceres as a *static* library (the default)
    #   you can use the SuiteSparse package in the main Ubuntu package
    #   repository:
    sudo apt-get install -y libsuitesparse-dev
    # - However, if you want to build Ceres as a *shared* library, you must
    #   add the following PPA:
    # sudo add-apt-repository ppa:bzindovic/suitesparse-bugfix-1319687
    # sudo apt-get update
    # sudo apt-get install -y libsuitesparse-dev

    # install ceres
    mkdir build
    cd build
    cmake ..
    make -j4
    sudo make install
fi

cd $DIR