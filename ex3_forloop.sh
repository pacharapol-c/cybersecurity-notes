#!/bin/bash

# loop แบบ list
echo "=== list loop ==="
for fruit in apple banana mango ; do
  echo "fruit: $fruit"
done

# loop แบบ range
echo "=== Range loop ==="
for i in {1..5}; do
  echo "number: $i"
done

# loop ไฟล์ใน directory
echo "=== Files in /etc ==="
for file in /etc/*.conf; do
  echo $file
done
