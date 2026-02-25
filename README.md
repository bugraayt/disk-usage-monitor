# Disk Usage Monitor

A bash script that checks disk usage on your system and warns you if any partition goes over the threshold.

---

## How it works

- Runs `df -h` to get current disk usage for all mounted filesystems
- Parses the output with `awk` to extract the filesystem, usage percentage and mount point
- Strips the `%` sign from the usage value so it can be compared as a number
- If usage is above 80%, it prints a warning to the terminal and writes it to `disk_usage.log` with a timestamp
- After each check it asks if you want to see only the disks over the threshold, then whether you want to run it again.
- Asks if you want to check again, loops until you say no 

---

## Requirements
Bash
Linux

---
## Example Output

Note: I changed the threshold from 80% to 2% to test it.

```
Current disk usage for /dev (devtmpfs): 0%
/dev disk usage is normal (0%).
Current disk usage for /dev/shm (tmpfs): 1%
/dev/shm disk usage is normal (1%).
Current disk usage for /run (tmpfs): 11%
WARNING!! /run disk usage is above 80 it's (11%)!
Current disk usage for /sys/fs/cgroup (tmpfs): 0%
/sys/fs/cgroup disk usage is normal (0%).
Current disk usage for / (/dev/mapper/cl-root): 3%
WARNING!! / disk usage is above 80 it's (3%)!
Current disk usage for /home (/dev/sdb1): 2%
/home disk usage is normal (2%).
Current disk usage for /boot (/dev/sda2): 31%
WARNING!! /boot disk usage is above 80 it's (31%)!

```

```
Do you want to see the disks over the treshold? (y/n)y
/run disk usage is above 80 it's (11%)!
/ disk usage is above 80 it's (3%)!
/boot disk usage is above 80 it's (31%)!
```

## Log File

Warnings are written to disk_usage.log with a timestamp.

```
WARNING!! /run disk usage is above 80 it's (11%)! Wed Feb 25 02:21:04 CET 2026
WARNING!! / disk usage is above 80 it's (3%)! Wed Feb 25 02:21:04 CET 2026
WARNING!! /boot disk usage is above 80 it's (31%)! Wed Feb 25 02:21:04 CET 2026
```

## macOS

The column order in df -h is different on macOS. Change this line:
```
df -h | awk 'NR>1 {print $1, $5, $6}'
```
to:
```
df -h | awk 'NR>1 && $1 != "devfs" {print $1, $5, $9}'
```