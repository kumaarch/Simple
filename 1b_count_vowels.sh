#!/bin/bash
echo "Enter a line of text:"
read line
count=$(echo "$line" | grep -o -i "[aeiou]" | wc -l)
echo "Number of vowels: $count"
