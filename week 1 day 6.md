# Day 6 — Processes, Ports & OverTheWire Bandit 3→6

**Date:** 2026-06-27 **Week:** W1 | **Phase:** 1 — Foundation **Time Spent:** ~2 hrs

---

## What I Learned

> A process is any running program in Linux, each with a unique PID. I practiced opening, inspecting, and killing processes using ps/kill, checked open ports with ss, and completed Bandit levels 3→6 using the file and find commands.

---

## Commands I Ran

### Opening background processes with sleep

```bash
sleep 100 &
sleep 200 &
sleep 300 &
```

**Output:**

```
[no output recorded]
```

**What this does:** Runs processes in the background using `&` so the terminal stays free. Used as practice targets for ps and kill.

---

### Viewing running processes

```bash
ps aux | grep sleep
```

**Output:**

```
asia         469  0.0  0.0   5264  1736 pts/2    S    10:59   0:00 sleep 200
asia         475  0.0  0.0   5264  1724 pts/2    S    10:59   0:00 sleep 300
asia         544  0.0  0.0   6344  1912 pts/0    S+   11:00   0:00 grep --color=auto sleep
```

**What this does:** Filters running processes by name. The last line (grep itself) is not an actual sleep process — it just shows up because grep matches its own command string.

---

### Killing a process

```bash
kill 469
kill 475
ps aux | grep sleep
```

**Output:**

```
asia         584  0.0  0.0   6344  1912 pts/0    S+   11:02   0:00 grep --color=auto sleep
```

**What this does:** Stops a process by PID. Only the grep line remains, confirming both sleep processes were successfully killed.

---

### Checking open ports

```bash
ss -tulpn
sudo ss -tulpn
```

**Output:**

```
Netid   State    Recv-Q   Send-Q      Local Address:Port       Peer Address:Port   Process
udp     UNCONN   0        0          10.255.255.254:53              0.0.0.0:*
udp     UNCONN   0        0               127.0.0.1:323             0.0.0.0:*
udp     UNCONN   0        0                   [::1]:323                [::]:*
tcp     LISTEN   0        1000       10.255.255.254:53              0.0.0.0:*
```

**What this does:** Port 53 = WSL2 DNS resolver, Port 323 = chronyd (time sync). The Process column was empty even with sudo — a known WSL2 limitation.

---

### Bandit 3→4 — Finding a hidden file

```bash
ssh bandit3@bandit.labs.overthewire.org -p 2220
cd inhere
ls -la
```

**Output:**

```
[no output recorded]
```

**What this does:** Hidden files start with `.` and are only visible with `ls -la`.

**Password obtained:** `xzTXq1rDJQVVAzdv5cHq1TQytTWufAMq`

---

### Bandit 4→5 — Finding the human-readable file

```bash
ssh bandit4@bandit.labs.overthewire.org -p 2220
cd inhere
ls
file ./-file00 ./-file01 ./-file02 ./-file03 ./-file04 ./-file05 ./-file06 ./-file07 ./-file08 ./-file09
cat ./-file07
```

**Output:**

```
./-file00: data
./-file01: data
./-file02: data
./-file03: data
./-file04: data
./-file05: OpenPGP Public Key
./-file06: data
./-file07: ASCII text
./-file08: data
./-file09: Motorola S-Record; binary data in text format
```

**What this does:** `file` reveals the type of each file. ASCII text = human-readable. Everything else is binary or a special format. Files starting with `-` require `./` prefix to avoid being interpreted as flags.

**Password obtained:** `6C7h9GD8M6ai5nr7wo1RonrzFjj9yIrG`

---

### Bandit 5→6 — Using find to filter by file size

```bash
ssh bandit5@bandit.labs.overthewire.org -p 2220
find inhere -size 1033c
```

**Output:**

```
[no output recorded]
```

**What this does:** `find` searches recursively through all subdirectories. `-size 1033c` filters by exact byte size. The file properties were given in the challenge description at overthewire.org.

**Password obtained:** `pXa26xhMWaC2SvDotA4r9EgZkulOeSBW`

---

## What I Understood

- Every running program is a process with a unique PID — visible with `ps`, stoppable with `kill`
- The grep line in `ps aux | grep` output is grep itself, not the actual target process
- `ss -tulpn` shows open ports — port 53 = DNS, 323 = time sync
- `file` checks file type before `cat` so I don't have to open every file blindly
- `find` searches recursively and can filter by size with `-size Nc`
- Files with names starting with `-` need `./` prefix to work correctly
- Always read the challenge description at overthewire.org before starting each level

---

## What Still Confused Me

- Don't have all commands memorized yet — but I know what process I need and can look up the right command
- `sudo ss -tulpn` doesn't show the Process column in WSL2 — not sure how to work around this

---

## References

- OverTheWire Bandit: https://overthewire.org/wargames/bandit/
- `man find`, `man file`, `man ss`

---

## Summary

> I can now open, inspect, and kill processes, read open port information, and use file and find to locate specific files efficiently instead of checking them one by one. More importantly, I understand the workflow: know what you're looking for, then find the right command — rather than memorizing everything upfront.