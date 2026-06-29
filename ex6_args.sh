#!/bin/bash

echo "Script name : $0"
echo "First arg   : $1"
echo "Second arg  : $2"
echo "All args    : $@"
echo "Arg count   : $#"

# ป้องกัน user ไม่ใส่ argument
if [ %# -eq 0 ]; then
  echo "usage:bash $0 <name><age>"
  exit 1
fi
echo echo "Hello, $1! You are $2 years old."
