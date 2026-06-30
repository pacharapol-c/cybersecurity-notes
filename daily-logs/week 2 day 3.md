# Day W2D3 — Regex, grep -E, sed, awk, tr

**Date:** 2026-06-30  
**Week:** W2 | **Phase:** 1 — Foundation  
**Time Spent:** ~2 hrs

---

## What I Learned
> Basic regex anchors (`^`, `$`) for precise pattern matching, and the core text-processing toolkit grep / sed / awk / tr — each with a distinct role: grep finds, sed edits/deletes, awk extracts columns, tr translates characters.

---

## Commands I Ran

### Inspecting /etc/passwd structure
```bash
cat /etc/passwd | head -5
```

**Output:**
root:x:0:0:root:/root:/bin/bash  
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin  
bin:x:2:2:bin:/bin:/usr/sbin/nologin  
sys:x:3:3:sys:/dev:/usr/sbin/nologin  
sync:x:4:65534:sync:/bin:/bin/sync

**What this does:**  
Shows the colon-separated fields of `/etc/passwd`: username : password placeholder : UID : GID : comment : home dir : shell.

---

### grep -E — matching users with /bin/bash shell
```bash
grep -E "/bin/bash$" /etc/passwd
grep -E "/bin/bash" /etc/passwd
```

**Output:**
`[no output recorded]`

**What this does:**  
`$` anchors the match to the end of the line, so it only matches lines that end exactly with `/bin/bash` — avoiding false positives like `/bin/bash-fake`. Without `$`, it matches anywhere in the line, so it would also catch lines like `/bin/bash-fake`.

---

### awk — extracting columns
```bash
awk -F: '{print $1}' /etc/passwd
awk -F: '$7 == "/bin/bash" {print $1}' /etc/passwd
```

**Output:**
`[no output recorded]`

**What this does:**  
`-F:` sets the field delimiter to `:`. `$1`, `$7` reference column 1 (username) and column 7 (shell). The pattern `$7 == "/bin/bash"` filters rows before printing — only prints the username if the shell column matches exactly.

---

### sed — deleting lines by pattern
```bash
echo -e "# this is comment\nroot:x:0:0\n# another comment\nuser:x:1000:1000" > test.txt
cat test.txt
sed '/^#/d' test.txt
```

**Output:**
`[no output recorded]`

**What this does:**  
`/pattern/d` deletes any line matching the pattern. `^#` matches lines starting with `#`, so only comment lines get removed. Tested the difference between `/^#/d` (anchored to start) vs `/#/d` (matches `#` anywhere) and vs `/t/d` (matches the letter `t` anywhere — accidentally deletes unrelated lines like `root` since it contains a `t`).

---

## What I Understood
- `^` anchors to start of line, `$` anchors to end of line — both critical for avoiding false positive matches.
- `awk -F:` splits a line into fields by `:`, and `$N` references the Nth field.
- `awk` can filter with a condition before `{print}`, e.g. `$7 == "/bin/bash"`.
- `sed '/pattern/d'` deletes lines matching pattern; `d` is the delete command, distinct from `s` (substitute) and `p` (print).
- Broad patterns (e.g. `/t/d`) are dangerous — they can match unintended lines (like `root` containing the letter `t`).
- `tr` is narrower than grep/sed/awk — only does character-level translation (e.g. ROT13, case conversion, deleting whitespace). Useful but lower priority than grep/awk/sed.

---

## What Still Confused Me
- Hasn't yet run the actual `awk` and `sed` commands against real terminal output (commands explained conceptually, not yet executed/pasted back).

---

## References
- `man grep`, `man sed`, `man awk`
- `/etc/passwd` man page (`man 5 passwd`)

---

## Summary
> Can now read and write basic regex anchors (`^`/`$`) and combine grep -E, awk -F, and sed '/pattern/d' to filter and extract structured text — a core skill for parsing logs and tool output during web pentesting.

## Bandit 12 — Attempted (not completed)

**Note:** Jumped ahead to try Bandit Level 12 today, outside of its scheduled slot (W2D6). Decided to stop and return to it later once SSH (W2D4) and TryHackMe (W2D5) are covered, since the level relies on tools never taught yet.

### Mission
Password is in `data.txt`, a hexdump of a file that has been repeatedly compressed. Recommended to work in a temp directory (`mktemp -d`), copy the file there, then decompress layer by layer.

### What I looked at
00000000: 1f8b 0808 b2f0 3b6a 0203 6461 7461 322e  ......;j..data2.
00000010: 6269 6e00 0142 02bd fd42 5a68 3931 4159  bin..B...BZh91AY
00000020: 2653 59dc 0966 8300 001a ffff dff5 c5fe  &SY..f..........
00000030: b8ef a7be bddb f8a7 febb ffc9 bfbf 9fbf  ................
00000040: b77b bfff fbd9 7ffe 5fef efcf b001 3b19  .{......_.....;.
00000050: 9206 87a9 a068 0340 3400 341a 1a1a 0340  .....h.@4.4....@
00000060: 1a68 068d 1a00 0646 8000 0610 0d00 069a  .h.....F........
00000070: 0640 683c a0d0 3d43 4d3d 4f51 b420 0680  .@h<..=CM=OQ. ..
00000080: d034 0000 0079 41a3 40d1 ea00 0f48 000d  .4...yA.@....H..
00000090: 1a34 d1ea 7a83 d468 f441 a03d 469a 3400  .4..z..h.A.=F.4.
000000a0: 6400 00d0 f500 d019 01a0 6534 d0f2 8320  d.........e4...
000000b0: 7a8d 3200 0000 0034 1ea1 e900 d000 d006  z.2....4........
000000c0: 8000 681a 6834 001a 0000 0006 d400 f50f  ..h.h4..........
000000d0: 507a 81fa a193 0142 1809 3e44 b214 426c  Pz.....B..>D..Bl
000000e0: b74f a3a8 bbad 1594 edb6 f107 af89 5c5d  .O............\]
000000f0: 4a31 234c c745 9085 a522 3fc7 8a68 2ae3  J1#L.E..."?..h*.
00000100: 7711 a0ea d795 527d c100 5da1 2783 2400  w.....R}..].'.$.
00000110: cbf5 1a40 2406 8e71 5365 27cb 01ed 5025  ...@$..qSe'...P%
00000120: 2623 64be 09cc 5f29 e33e ebaa cef0 a814  &#d..._).>......
00000130: a1d2 46b8 785c 5a2c a007 a388 d38b b49b  ..F.x\Z,........
00000140: e734 d6e2 c9dc 2de3 7a0d 0792 6586 4748  .4....-.z...e.GH
00000150: e901 f017 5076 a0cc 6009 1e12 54a4 23dd  ....Pv..`...T.#.
00000160: 1e33 d761 f76c f2a8 e56a d4e9 c80d 996e  .3.a.l...j.....n
00000170: 6494 dfa7 5618 2f5c a486 0b53 eef5 4855  d...V./\...S..HU
00000180: 5f30 8da5 4e0a 123b c4f1 3209 b120 0bf2  _0..N..;..2.. ..
00000190: 9838 9754 2f21 ee96 1df2 9eb1 8682 1ae3  .8.T/!..........
000001a0: 7fd0 e58a 73c2 a955 c7ff 6ca2 349c ba62  ....s..U..l.4..b
000001b0: 7885 8425 4fdc 6346 43e6 f44e 84ad ef1c  x..%O.cFC..N....
000001c0: 981f 6080 aa78 3467 401f 3e9e b6d3 dda9  ..`..x4g@.>.....
000001d0: 669a 3a81 0332 6d67 5800 f837 683f 04a6  f.:..2mgX..7h?..
000001e0: 0871 f24f 6c87 3b10 03c0 fa0c ced1 7bbc  .q.Ol.;.......{.
000001f0: 7f4d 7906 abf6 91fc 403d a92c c863 8966  .My.....@=.,.c.f
00000200: 4cc6 2b9b c8b2 2058 36a0 b385 347b 299a  L.+... X6...4{).
00000210: 51f2 1fa0 e32b 9669 bc78 8209 923b 0fca  Q....+.i.x...;..
00000220: c29e 30a2 aacf 65b5 696e f7cb a5af 9b6c  ..0...e.in.....l
00000230: e6cd 4413 f7f0 6200 1c3c 67d9 d917 ddff  ..D...b..<g.....
00000240: 9c50 2d14 54ca 1c86 6835 2418 cb8b 2e42  .P-.T...h5$....B
00000250: bc5d c914 e142 4370 259a 0c7f 1988 6542  .]...BCp%.....eB
00000260: 0200 00
**What this does (analysis only, not yet executed):**  
Identified magic bytes by reading hex manually: `1f8b` = gzip signature, embedded filename `data2.bin` readable in the gzip header, followed by `BZh9` = bzip2 signature — meaning the file is gzip-compressed, containing a bzip2-compressed file inside, suggesting multiple layers of compression to peel back.

### Tools encountered but not yet learned
- `xxd -r` — reverse a hexdump back into binary
- `mktemp -d` — create a temp working directory
- `gzip` / `gunzip`, `bzip2` / `bunzip2` — decompression tools
- `file <filename>` — identify file type from binary content

---

## What Still Confused Me (update)
- None of the tools needed for Bandit 12 (xxd, gzip/bzip2, file command, mktemp) have been taught yet — recognized this mid-attempt and decided to pause rather than proceed without understanding.

---

## Summary (update)
> Attempted Bandit 12 ahead of schedule and recognized it requires tools not yet covered (compression, hexdump, file identification). Decided to return to the regular path (W2D4 SSH next) and revisit Bandit 12 at its scheduled slot (W2D6) once the prerequisite tools are introduced.