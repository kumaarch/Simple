#!/bin/bash
echo "Enter radius of the circle:"
read r
pi=3.1416
area=$(echo "scale=4; $pi * $r * $r" | bc)
circumference=$(echo "scale=4; 2 * $pi * $r" | bc)
echo "Area of circle: $area"
echo "Circumference of circle: $circumference"
