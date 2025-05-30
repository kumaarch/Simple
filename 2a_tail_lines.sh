#!/bin/bash
echo "Enter filename:"
read filename
tail -n 10 "$filename"
