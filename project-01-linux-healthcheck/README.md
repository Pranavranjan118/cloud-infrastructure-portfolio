# Project 1 — Linux Server Health-Check Toolkit

## Problem
Small teams need a quick, repeatable way to check common server health signals without manually running several commands.

## What it checks
- Root filesystem usage
- Memory usage (Linux `/proc/meminfo`)
- Load average
- Selected systemd service status (if `systemctl` is available)
- Timestamped log/report output

## Requirements
- Bash 4+
- Linux
- Optional: `systemctl` for service checks

## Run
```bash
chmod +x healthcheck.sh
./healthcheck.sh
```

Optional environment variables:
```bash
DISK_WARN_PERCENT=80 MEM_WARN_PERCENT=85 LOAD_WARN_PER_CPU=1 \
SERVICES="sshd cron" LOG_DIR="./logs" ./healthcheck.sh
```

Service names vary by distribution. On some systems the SSH service may be named `ssh` rather than `sshd`.

## Validation checklist
- [ ] Run on a test Linux VM.
- [ ] Confirm the report file is created.
- [ ] Test with a warning threshold deliberately lowered.
- [ ] Test with a service that does not exist.
- [ ] Inspect exit code and log output.
- [ ] Add sanitized terminal screenshots to `evidence/`.

## Limitations
This is a simple operational helper, not a monitoring replacement. It does not send alerts, collect historical metrics, or guarantee accurate diagnosis of every performance issue.
