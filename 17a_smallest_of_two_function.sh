#!/bin/bash

# Function to find smallest number
smallest() {
  if [ $1 -lt $2 ]; then
    echo "$1"
  else
    echo "$2"
  fi
}

# Read two numbers from user
read -p "Enter first number: " num1
read -p "Enter second number: " num2

# Call function and display result
result=$(smallest $num1 $num2)
echo "The smallest number is: $result"
