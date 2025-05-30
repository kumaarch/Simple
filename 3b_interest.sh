#!/bin/bash
echo "Enter Principal:"
read p
echo "Enter Rate of Interest (in %):"
read r
echo "Enter Time (in years):"
read t

si=$(echo "scale=2; ($p * $r * $t) / 100" | bc)
ci=$(echo "scale=2; $p * (1 + $r / 100)^$t - $p" | bc -l)

echo "Simple Interest: $si"
echo "Compound Interest: $ci"
