#!/usr/bin/env bash
# Linux server health-check toolkit — portfolio/lab example.
set -uo pipefail

DISK_WARN_PERCENT="${DISK_WARN_PERCENT:-80}"
MEM_WARN_PERCENT="${MEM_WARN_PERCENT:-85}"
LOAD_WARN_PER_CPU="${LOAD_WARN_PER_CPU:-1}"
SERVICES="${SERVICES:-sshd cron}"
LOG_DIR="${LOG_DIR:-./logs}"

mkdir -p "$LOG_DIR"
HOST="$(hostname 2>/dev/null || printf 'unknown-host')"
STAMP="$(date '+%Y%m%d-%H%M%S')"
REPORT="$LOG_DIR/health-${HOST}-${STAMP}.log"
WARNINGS=0

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$REPORT"
}

log "Health check started for host=$HOST"
log "Kernel: $(uname -sr 2>/dev/null || printf 'unknown')"

# Root filesystem usage (portable enough for common GNU/Linux systems).
disk_used="$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')"
if [[ "$disk_used" =~ ^[0-9]+$ ]]; then
  log "Root filesystem usage: ${disk_used}% (warning threshold ${DISK_WARN_PERCENT}%)"
  if (( disk_used >= DISK_WARN_PERCENT )); then
    log "WARNING: root filesystem usage is at or above threshold"
    WARNINGS=$((WARNINGS + 1))
  fi
else
  log "WARNING: unable to parse root filesystem usage"
  WARNINGS=$((WARNINGS + 1))
fi

# Memory use based on MemTotal and MemAvailable from /proc/meminfo.
if [[ -r /proc/meminfo ]]; then
  read -r mem_total mem_available < <(
    awk '/^MemTotal:/ {total=$2} /^MemAvailable:/ {available=$2} END {print total, available}' /proc/meminfo
  )
  if [[ "${mem_total:-}" =~ ^[0-9]+$ && "${mem_available:-}" =~ ^[0-9]+$ && "$mem_total" -gt 0 ]]; then
    mem_used=$(( (mem_total - mem_available) * 100 / mem_total ))
    log "Memory used: ${mem_used}% (warning threshold ${MEM_WARN_PERCENT}%)"
    if (( mem_used >= MEM_WARN_PERCENT )); then
      log "WARNING: memory usage is at or above threshold"
      WARNINGS=$((WARNINGS + 1))
    fi
  else
    log "WARNING: unable to parse memory information"
    WARNINGS=$((WARNINGS + 1))
  fi
else
  log "WARNING: /proc/meminfo is unavailable"
  WARNINGS=$((WARNINGS + 1))
fi

# Load average normalized by CPU count.
load_1="$(awk '{print $1}' /proc/loadavg 2>/dev/null || true)"
cpu_count="$(getconf _NPROCESSORS_ONLN 2>/dev/null || printf '1')"
log "Load average (1m): ${load_1:-unknown}; online CPUs: $cpu_count"
if [[ "${load_1:-}" =~ ^[0-9]+([.][0-9]+)?$ && "$cpu_count" =~ ^[0-9]+$ && "$cpu_count" -gt 0 ]]; then
  load_limit="$(awk -v n="$cpu_count" -v t="$LOAD_WARN_PER_CPU" 'BEGIN {printf "%.3f", n*t}')"
  over="$(awk -v l="$load_1" -v m="$load_limit" 'BEGIN {print (l >= m) ? 1 : 0}')"
  if [[ "$over" == "1" ]]; then
    log "WARNING: load average is at or above configured normalized threshold ($load_limit)"
    WARNINGS=$((WARNINGS + 1))
  fi
fi

if command -v systemctl >/dev/null 2>&1; then
  for service in $SERVICES; do
    if systemctl is-active --quiet "$service"; then
      log "Service $service: active"
    else
      log "WARNING: Service $service is not active or could not be queried"
      WARNINGS=$((WARNINGS + 1))
    fi
  done
else
  log "INFO: systemctl not found; skipping systemd service checks"
fi

log "Health check completed. Warning count=$WARNINGS"
if (( WARNINGS > 0 )); then
  exit 1
fi
exit 0
