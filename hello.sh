#!/bin/bash

name=$1

if [ -z "$name" ]; then
  echo "Usage: bash hello.sh <your name>"
  exit 1
fi

echo "Hello, $name!"
echo "Today is: $(date)"
echo "You are logged in as: $(whoami)"
