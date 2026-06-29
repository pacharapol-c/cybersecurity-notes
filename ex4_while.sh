#!/bin/bash

#นับ1-5
count=1
while [ $count -le 5 ]; do
  echo "count: $count"
  count=$((count+1))
done

# อ่านไฟล์ทีละบรรทัด (สำคัญมากใน pentest)
echo "=== Reading /etc/passwd line by line ==="
while IFS= read -r line; do
  echo "$line"
done < /etc/passwd | head -5


