#!/bin/bash
echo "Enter the current filename:"
read old
echo "Enter the new filename:"
read new
mv "$old" "$new"
echo "File renamed from $old to $new"
