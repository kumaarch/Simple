#!/bin/bash

echo "Enter base of the triangle:"
read base

echo "Enter height of the triangle:"
read height

area=$(echo "0.5 * $base * $height" | bc)

echo "Area of the triangle is: $area"
