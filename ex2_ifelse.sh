#!/bin/bash
age=17

if [ $age -ge 18 ]; then
  echo "adult"
else 
  echo "minor"
fi

# เช็ค string
name="admin"
if [ "$name" == "admin" ];then
  echo "welcome, admin"
else 
  echo "access decined"
fi

# เช็ค file มีอยู่ไหม
if [ -f "/etc/passwd" ]; then
  echo "/etc/passwd exits"
fi 
