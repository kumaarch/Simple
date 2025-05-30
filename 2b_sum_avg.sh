#!/bin/bash
echo "Enter four integers:"
read a b c d
sum=$((a + b + c + d))
avg=$((sum / 4))
echo "Sum: $sum"
echo "Average: $avg"
