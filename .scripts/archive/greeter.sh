#!/bin/bash

#run with '.scripts/greeter.sh -n Peter'

while getopts "n:" arg; do
  case $arg in
    n) Name=$OPTARG;;
  esac
done

echo "Hello $Name!"
