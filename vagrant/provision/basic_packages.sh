#!/bin/bash -eu

# https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash

echo "-------------------------------------------------------------"
echo "-------> Starting 'install_basic_packages.sh' script <-------"
echo "-------------------------------------------------------------"

echo "----> Installing basic packages"
## declare an array variable
declare -a arr=("byobu" "curl" "git" "htop" "iftop" "ipython" "ipython3" "ncdu" "netcat" "net-tools" "nmap" "python" "python3" "tree" "vim")

# declare FRONTEND environment variable
#export FRONTEND=noninteractive
#unset FRONTEND

## now loop through the above array
for i in "${arr[@]}"
do
  echo "--> Installing package:" $i
  DEBIAN_FRONTEND=noninteractive apt-get install -y $i
  # or do whatever with individual element of the array
done
