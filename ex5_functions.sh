#!/bin/bash

#function พื้นฐาน
greet() {
  echo "hello, $1!"
}

greet "hacker"
greet "admin"

# function คืนค่า (ผ่าน echo)
add() {
  local result=$(( $1 + $2 ))
  echo $result
}

sum=$(add 10 20)
echo "10 + 20 = $sum"

# function เช็ค port (จะใช้จริงใน pentest)
check_port() {
  local host=$1
  local port=$2
  if timeout 1 bash -c "choo > /dev/tcp/$host/$port" 2>/dev/null; then
    echo "port $port on $host: open"
  else
    echo "Port $port on $host: CLOSED"
  fi
}

check_port "google.com" 80
check_port "google.com" 22

