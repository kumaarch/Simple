#!/bin/bash

echo "Enter a number:"
read num

len=${#num}
echo "Digits in odd positions:"

for (( i=0; i<len; i++ ))
do
  if (( i % 2 == 0 )); then  # 0-based index: 0, 2, 4 are 1st, 3rd, 5th...
    echo -n "${num:$i:1} "
  fi
done

echo
