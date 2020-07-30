#!/bin/bash -eu

# https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash

echo "-------------------------------------------------------------"
echo "-------> Starting 'install_basic_packages.sh' script <-------"
echo "-------------------------------------------------------------"

echo "----> Installing basic packages"
## declare an array variable
declare -a arr=("git" "htop" "tree" "ncdu" "vim" "net-tools" "byobu" "iftop" "python" "ipython" "python3" "ipython3")

# declare FRONTEND environment variable
#export FRONTEND=noninteractive
#unset FRONTEND

## now loop through the above array
for i in "${arr[@]}"
do
  echo "----> Installing following package:" $i
  DEBIAN_FRONTEND=noninteractive apt-get install -y $i
  # or do whatever with individual element of the array
done
