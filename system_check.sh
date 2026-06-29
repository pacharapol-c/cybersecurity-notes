#!/bin/bash

echo "=== System Check ==="
echo ""

# 1. บอกว่าใครใช้อยู่
echo "[*] User: $(whoami)"

# 2. บอกว่าอยู่ที่ไหน
echo "[*] Location: $(pwd)"

# 3. แสดง 5 process ที่ใช้ memory เยอะสุด
echo ""
echo "[*] Top 5 processes:"
count=0
while IFS= read -r line; do
  if [ $count -lt 5 ]; then
    echo "    $line"
    count=$((count + 1))
  fi
done < <(ps aux --sort=-%mem | tail -n +2)

# 4. เช็คว่าไฟล์สำคัญมีอยู่ไหม
echo ""
echo "[*] Checking important files:"
for file in /etc/passwd /etc/hosts /etc/hostname /etc/fakefile; do
  if [ -f "$file" ]; then
    echo "    [OK] $file"
  else
    echo "    [MISSING] $file"
  fi
done

echo ""
echo "=== Done ==="
