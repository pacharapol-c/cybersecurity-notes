# Day 08 — Bash Scripting: Loops, Functions, Arguments

**Date:** 2026-06-29 **Week:** W2 | **Phase:** 1 — Foundation **Time Spent:** 3–4 hrs

---

## What I Learned

Bash scripting fundamentals — loops (for/while), functions with arguments, and script arguments ($1, $2, $@). Also decoded Base64 and solved ROT13 on Bandit Level 10–11.

---

## Commands I Ran

### Variables and Arithmetic

```bash
name="hacker"
age=20
greeting="Hello, $name! You are $age years old."
echo $greeting

x=10
y=3
echo "Sum: $((x + y))"
echo "Multiply: $((x * y))"
echo "Divide: $((x / y))"
```

**What this does:** Assigns variables and performs arithmetic. Learned that there must be no spaces around `=` in Bash (unlike Python), and that `$(())` is required for math — plain `x+y` is just a string.

---

### if/else

```bash
age=17
if [ $age -ge 18 ]; then
  echo "Adult"
else
  echo "Minor"
fi
```

**What this does:** Checks a condition and branches. Learned that spaces inside `[ ]` are required — `[$age]` causes a "command not found" error because Bash reads `[` as a command.

---

### for loop

```bash
for fruit in apple banana mango; do
  echo "Fruit: $fruit"
done

for i in {1..5}; do
  echo "Number: $i"
done
```

**What this does:** Loops over a list or a range. Each iteration assigns the current value to the variable. Learned that Bash uses `do`/`done` to open/close loops, and `$i` not `%i` for variables.

---

### while loop + read file line by line

```bash
count=1
while [ $count -le 5 ]; do
  echo "Count: $count"
  count=$((count + 1))
done

while IFS= read -r line; do
  echo "$line"
done < /etc/passwd | head -5
```

**What this does:** while loop runs until a condition is false. The `while IFS= read -r line` pattern reads a file one line at a time — used in pentest to iterate through wordlists.

---

### Functions

```bash
greet() {
  echo "Hello, $1!"
}
greet "hacker"

add() {
  local result=$(( $1 + $2 ))
  echo $result
}
sum=$(add 10 20)
echo "10 + 20 = $sum"
```

**What this does:** Functions group reusable code. `$1`, `$2` are arguments passed in at call time. `local` keeps variables scoped inside the function. Functions return values via `echo`, captured with `$()`.

---

### Script Arguments

```bash
echo "Script: $0"
echo "First: $1"
echo "All: $@"
echo "Count: $#"

if [ $# -eq 0 ]; then
  echo "Usage: bash $0 <name>"
  exit 1
fi
```

**What this does:** Scripts can accept arguments from the command line. `$0` = script name, `$1`/`$2` = arguments, `$@` = all arguments, `$#` = count. `exit 1` stops the script with an error if no arguments are given.

---

### Mini Project — system_check.sh

```bash
bash system_check.sh
```

**Output:**

```
=== System Check ===

[*] User: asia
[*] Location: /home/asia/practice/w2d2

[*] Top 5 processes:
    root  42  0.0  0.0  49788 15188 ?  Ss  10:36  0:00 /usr/lib/systemd/systemd-journald
    root   1  0.0  0.0  25380 14656 ?  Ss  10:36  0:00 /sbin/init
    asia 220  0.0  0.0  23088 12804 ?  Ss  10:36  0:00 /usr/lib/systemd/systemd --user
    root  52  0.0  0.0  37852 12364 ?  Ss  10:36  0:01 /usr/lib/systemd/systemd-udevd
    root 116  0.0  0.0  17320  8480 ?  Ss  10:36  0:00 /usr/lib/systemd/systemd-logind

[*] Checking important files:
    [OK] /etc/passwd
    [OK] /etc/hosts
    [OK] /etc/hostname
    [MISSING] /etc/fakefile

=== Done ===
```

**What this does:** Combined all concepts — `$()` for commands, while loop for top 5 processes, for loop with `-f` check for files. `[*]` is just a label style common in security tools, not special syntax.

---

### Bandit Level 10 → 11 → 12

**Level 10 — Base64**

```bash
cat data.txt | base64 -d
# VGhlIHBhc3N3b3JkIGlzIHBZZk9ZNkh3VXNEajVyTDlVdnloVTdNQ212OHZONVJvCg==
# → pYfOY6HwUsDj5rL9UvyhU7MCmv8vN5Ro
```

**Level 11 — ROT13**

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
# Gur cnffjbeq vf TEBbmJCB8DlA0zTewHxVQ0JPLxMvDkeA
# → GROozWPO8QyN0mGrjUkID0WCYkZiQxrN
```

**What this does:** Base64 encodes binary data as printable text — not encryption, anyone can decode it. ROT13 shifts each letter by 13 positions. `tr` translates characters from one set to another.

---

### First GitHub Push

```bash
git config --global user.name "pacharapol-c"
git config --global user.email "..."
git init
git remote add origin https://github.com/pacharapol-c/cybersecurity-notes.git
git branch -m main
git add .
git commit -m "W2D2: bash scripting - loops, functions, args, system_check"
git push -u origin main --force
```

**What this does:** First time pushing to GitHub from Kali WSL2. Used Personal Access Token instead of password. `--force` was needed because remote had existing commits.

---

## What I Understood

- Bash variable assignment has no spaces around `=` (unlike Python)
- `[ ]` requires spaces inside — Bash reads `[` as a command
- `$()` runs a command; `$(())` does math — they are different
- `do`/`done` closes loops; `then`/`fi` closes if blocks; `{`/`}` closes functions
- `while IFS= read -r line; do ... done < file.txt` is the pattern for reading files line by line
- Functions return values via `echo`, captured with `$()`
- `$1 $2 $@ $#` for script arguments
- Base64 is encoding not encryption — anyone can decode without a key
- ROT13 shifts letters by 13 — decoded with `tr`

---

## What Still Confused Me

- Reading larger scripts (system_check.sh) is harder than reading small ones — can read small projects but cannot write from scratch yet
- `tr` syntax for ROT13 — used it but not fully understood yet (will cover W2D3)
- `ps aux --sort=-%mem | tail -n +2` — understood the pieces but combining them feels complex

---

## References

- OverTheWire Bandit: https://overthewire.org/wargames/bandit/
- GitHub repo: https://github.com/pacharapol-c/cybersecurity-notes

---

## Summary

> Can write basic bash scripts using variables, loops, functions, and arguments. Can read small scripts and understand what each line does. Cannot yet write complex scripts from scratch. Pushed first files to GitHub from Kali WSL2. Solved Bandit Level 10 (Base64) and Level 11 (ROT13) independently.
