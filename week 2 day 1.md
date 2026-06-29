
---

# Day 7 — Bash Scripting + Bandit 6→10

**Date:** 2026-06-28 **Week:** W2D1 | **Phase:** 1 — Foundation **Time Spent:** ~2 hrs

---

## What I Learned

Bash scripting fundamentals — variables, if/else conditions, and for loops. Also learned how to find files by ownership and filter command output using pipes and stream redirection.

---

## Commands I Ran

### Bash — Variable

```bash
#!/bin/bash
name="Pacharapol"
echo "Hello, $name"
```

**Output:**

```
Hello, Pacharapol
```

**What this does:** Stores a value in a variable and prints it. `echo` is bash's version of `print`.

---

### Bash — If/Else

```bash
#!/bin/bash
age=20

if [ $age -ge 18 ]; then
  echo "You are an adult"
else
  echo "You are a minor"
fi
```

**Output:**

```
You are an adult
```

**What this does:** Checks if age >= 18 using `-ge`. `[ ]` is the test condition block — spaces inside are required. `fi` closes the if block.

---

### Bash — For Loop

```bash
#!/bin/bash
for i in 1 2 3 4 5; do
  echo "Number: $i"
done
```

**Output:**

```
Number: 1
Number: 2
Number: 3
Number: 4
Number: 5
```

**What this does:** Loops through each value and prints it. `done` closes the loop block.

---

### Bash — Combined (Port Checker)

```bash
#!/bin/bash
ports="80 443 22 8080"

for port in $ports; do
  if [ $port -eq 80 ] || [ $port -eq 443 ]; then
    echo "Port $port: Web traffic"
  else
    echo "Port $port: Other"
  fi
done
```

**Output:**

```
Port 80: Web traffic
Port 443: Web traffic
Port 22: Other
Port 8080: Other
```

**What this does:** Combines variable, loop, and if/else into a script that categorizes ports — similar to real pentest automation.

---

### Bandit 6→7 — find by ownership

```bash
find / -user bandit7 -group bandit6 -size 33c 2>/dev/null
```

**Output:**

```
/var/lib/dpkg/info/bandit7.password
```

**What this does:** Searches the entire server for a file owned by user `bandit7`, group `bandit6`, size 33 bytes. `2>/dev/null` discards all permission-denied errors so only real results show.

---

### Bandit 7→8 — grep keyword

```bash
grep "millionth" data.txt
```

**What this does:** Finds the line containing the target word directly.

---

### Bandit 8→9 — unique line

```bash
sort data.txt | uniq -u
```

**What this does:** `sort` groups duplicate lines together, then `uniq -u` shows only lines that appear exactly once.

---

### Bandit 9→10 — strings + grep

```bash
strings data.txt | grep "==="
```

**What this does:** `strings` extracts human-readable text from a binary file, then `grep` filters lines starting with `===`.

---

## sort and uniq — Essential Reference

```bash
sort file.txt           # เรียงบรรทัด A→Z
sort -r file.txt        # เรียง Z→A
sort -n file.txt        # เรียงตัวเลข

uniq file.txt           # ลบบรรทัดซ้ำติดกัน (ต้อง sort ก่อน)
uniq -u file.txt        # แสดงเฉพาะบรรทัดที่ไม่ซ้ำเลย
uniq -c file.txt        # นับจำนวนซ้ำแต่ละบรรทัด
```

**ใช้บ่อยใน pentest:**

```bash
sort wordlist.txt | uniq > clean_wordlist.txt   # กรอง wordlist ก่อน brute force
sort results.txt | uniq -u                       # หา finding ที่เจอครั้งเดียว
```

---

## What I Understood

- Variables, if/else, for loops in bash — can read and predict output
- `chmod +x` gives execute permission — needed before running `.sh` files
- `2>/dev/null` redirects stderr to discard — cleans up noisy output
- `find` flags: `-user`, `-group`, `-size` for filtering files by ownership
- `sort | uniq -u` pattern for finding unique lines

---

## What Still Confused Me

- Nothing blocking — some syntax not memorized yet but readable when seen

---

## References

- OverTheWire Bandit: https://overthewire.org/wargames/bandit/
- Bash scripting basics: https://tldp.org/LDP/abs/html/

---

## Summary

Can write basic bash scripts combining variables, conditions, and loops. Can read a script and predict its output without running it. Reached Bandit Level 10 — ahead of schedule.