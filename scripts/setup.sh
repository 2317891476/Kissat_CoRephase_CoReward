#!/bin/bash

# Update package list and install required packages
sudo apt-get update
apt-get install p7zip-full

# Install drat-trim
cd env/drat-trim
make
cd ..

# Install drabt
cd drabt-004
make
cd ../..

# Build the SAT solver
make clean
./configure 
make 
cd ../
