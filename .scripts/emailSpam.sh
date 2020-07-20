#!/bin/bash

#call this script: emailSpam.sh <recipient> <number of iterations> <message to repeat>

#2nd and 3rd argument are optional
numIters=${2:-50}
message=${3:-"boop "}

echo "Iterations:"$numIters
echo "Message:   "$message
touch $1_tmp.txt
for i in $(seq 1 $numIters);
  do
  echo $i
  echo -n "Subject: " $i> $1_tmp.txt;
  for j in $(seq 1 $i);
    do
      echo -n "$message" >> $1_tmp.txt;
    done;
  echo "" >> $1_tmp.txt;
  sleep $i;
  ssmtp $1 < $1_tmp.txt;
done
rm $1_tmp.txt
