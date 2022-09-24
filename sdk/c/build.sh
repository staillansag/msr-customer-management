#!/bin/bash

echo "******************************************"
echo "Remember to set environment variables!"
echo "See environment_settings for more details!"
echo "******************************************"
echo ""
cd build
make
cd ..
cd src
make runtest
cd ..
echo "Finished build"

