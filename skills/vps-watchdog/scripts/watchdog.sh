#!/bin/bash
#
# VPS Watchdog — Security + Resource Monitor
# Runs every 30 minutes, alerts only on real threats + critical resource usage
#
# Checks:
#   1. Cryptominers + suspicious processes
#   2. Brute-force attacks (fail2ban status)
#   3. CPU/RAM usage (no false positives on spikes)
#   4. Rootkit indicators
#   5. Unexpected cron/SUID changes
#

set -euo pipefail

LOGFILE="/var/log/vps-watchdog.log"
ALERT_FILE="/tmp/vps-watchdog-alert.txt"
NUM_CORES=$(nproc)
CRITICAL_LOAD=$((NUM_CORES * 3))
CRITICAL_CPU=85
CRITICAL_RAM=90

# Cleanup
rm -f "$ALERT_FILE"

# Log function
log_alert() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ALERT: $*" | tee -a "$LOGFILE" >> "$ALERT_FILE"
}

log_info() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: $*" >> "$LOGFILE"
}

# =============================================================================
# 1. CHECK FOR CRYPTOMINERS
# =============================================================================
check_miners() {
    log_info "Checking for cryptominers..."
    local miner_names=("xmrig" "minerd" "cpuminer" "cryptonight" "nicehash" "kswapd0d" "kdevtmpfsi" "kinsing" "kthreadd2" "sysupdate" "networkservice")
    local found=0

    for miner in "${miner_names[@]}"; do
        if pgrep -i "$miner" > /dev/null 2>&1; then
            log_alert "CRYPTOMINER DETECTED: $miner"
            ps aux | grep -i "$miner" | grep -v grep >> "$ALERT_FILE"
            found=1
        fi
    done

    return $found
}

# =============================================================================
# 2. CHECK FOR SUSPICIOUS PROCESSES
# =============================================================================
check_suspicious_procs() {
    log_info "Checking for suspicious processes..."
    local alert=0

    # Check for unexpected root processes — exclude kernel threads (in []) and known services
    local root_procs=$(ps aux | grep "^root" | grep -v '\[' | grep -vE "systemd|cron|kworker|sshd|sudo|docker|postgres|mysql|nginx|apache|fail2ban|packagekit|polkit|dbus|udev|journald|rsyslog|psimon|logind|networkd|resolved|unattended|apt|dpkg|python|watchdog|multipathd|qemu-ga|agetty|atd|sshd" | wc -l)
    if [ "$root_procs" -gt 8 ]; then
        log_alert "UNUSUAL ROOT PROCESSES: $root_procs unexpected non-kernel root procs"
        ps aux | grep "^root" | grep -v '\[' | grep -vE "systemd|cron|sshd|sudo|fail2ban|packagekit|polkit|udev|journald|rsyslog|logind|networkd|resolved|unattended|multipathd|qemu-ga|agetty|atd|python|watchdog" >> "$ALERT_FILE"
        alert=1
    fi

    # Check for processes EXECUTING FROM /tmp or /dev/shm (not just using it as data dir)
    # agent-browser legitimately uses /tmp/agent-browser-chrome-* as user-data-dir — exclude it
    local tmp_procs=$(ps aux | grep ' /tmp/' | grep -v 'user-data-dir=/tmp/' | grep -v 'grep' | grep -v 'agent-browser' | grep -v 'vps-watchdog')
    if [ -n "$tmp_procs" ]; then
        log_alert "SUSPICIOUS PROCESS EXECUTING FROM /tmp"
        echo "$tmp_procs" >> "$ALERT_FILE"
        alert=1
    fi

    if pgrep -f "/dev/shm/" > /dev/null 2>&1; then
        log_alert "SUSPICIOUS PROCESS IN /dev/shm"
        pgrep -f "/dev/shm/" | xargs ps aux 2>/dev/null >> "$ALERT_FILE" || true
        alert=1
    fi

    return $alert
}

# =============================================================================
# 3. CHECK BRUTE-FORCE ATTACKS (fail2ban)
# =============================================================================
check_brute_force() {
    log_info "Checking brute-force attacks..."
    local alert=0

    # SSH brute-force is normal internet background noise — fail2ban handles it automatically.
    # Only alert if fail2ban itself is DOWN (not running), which is a real problem.
    if ! sudo fail2ban-client status sshd > /dev/null 2>&1; then
        log_alert "FAIL2BAN IS DOWN — SSH is unprotected"
        alert=1
    else
        log_info "fail2ban is active and protecting SSH"
    fi

    return $alert
}

# =============================================================================
# 4. CHECK CPU USAGE (sustained, not spike)
# =============================================================================
check_cpu() {
    log_info "Checking CPU usage..."
    local alert=0

    # Get 3 samples over 15 seconds to avoid false positives from spikes
    local cpu1=$(grep "cpu " /proc/stat | awk '{print int(($2+$3+$4) * 100 / ($2+$3+$4+$5))}')
    sleep 5
    local cpu2=$(grep "cpu " /proc/stat | awk '{print int(($2+$3+$4) * 100 / ($2+$3+$4+$5))}')
    sleep 5
    local cpu3=$(grep "cpu " /proc/stat | awk '{print int(($2+$3+$4) * 100 / ($2+$3+$4+$5))}')

    local avg_cpu=$(( (cpu1 + cpu2 + cpu3) / 3 ))

    log_info "CPU sustained average: $avg_cpu%"

    if [ "$avg_cpu" -gt "$CRITICAL_CPU" ]; then
        log_alert "CRITICAL CPU USAGE: ${avg_cpu}%"
        ps aux --sort=-%cpu | head -10 >> "$ALERT_FILE"
        alert=1
    fi

    return $alert
}

# =============================================================================
# 5. CHECK RAM USAGE (excluding cache)
# =============================================================================
check_ram() {
    log_info "Checking RAM usage..."
    local alert=0

    # Get RAM usage (exclude buffer/cache)
    local ram_total=$(grep "MemTotal" /proc/meminfo | awk '{print $2}')
    local ram_available=$(grep "MemAvailable" /proc/meminfo | awk '{print $2}')
    local ram_used=$(( (ram_total - ram_available) * 100 / ram_total ))

    log_info "RAM usage: ${ram_used}% of ${ram_total}kB"

    if [ "$ram_used" -gt "$CRITICAL_RAM" ]; then
        log_alert "CRITICAL RAM USAGE: ${ram_used}%"
        ps aux --sort=-%mem | head -10 >> "$ALERT_FILE"
        alert=1
    fi

    return $alert
}

# =============================================================================
# 6. CHECK LOAD AVERAGE
# =============================================================================
check_load() {
    log_info "Checking load average..."
    local alert=0

    local load=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
    load=${load%.*}  # Remove decimal

    log_info "Load average: $load (threshold: $CRITICAL_LOAD)"

    if [ "$load" -gt "$CRITICAL_LOAD" ]; then
        log_alert "CRITICAL LOAD: $load (threshold: $CRITICAL_LOAD)"
        uptime >> "$ALERT_FILE"
        alert=1
    fi

    return $alert
}

# =============================================================================
# 7. CHECK FOR ROOTKIT INDICATORS
# =============================================================================
check_rootkit() {
    log_info "Checking rootkit indicators..."
    local alert=0

    # Check for unexpected cron entries
    if [ -d /var/spool/cron/crontabs ]; then
        local cron_count=$(ls -1 /var/spool/cron/crontabs 2>/dev/null | wc -l)
        log_info "Cron users: $cron_count"
        # Only alert if there are unexpected cron users (>3 is unusual for a VPS)
        if [ "$cron_count" -gt 5 ]; then
            log_alert "UNUSUAL CRON ACTIVITY: $cron_count users have cron jobs"
            ls -la /var/spool/cron/crontabs >> "$ALERT_FILE" 2>/dev/null || true
            alert=1
        fi
    fi

    # Check for unexpected SUID binaries (compare to baseline if exists)
    # For now, just warn on any SUID in /tmp or /dev/shm
    if find /tmp /dev/shm -perm -4000 2>/dev/null | grep -q .; then
        log_alert "SUID BINARY IN /tmp or /dev/shm"
        find /tmp /dev/shm -perm -4000 2>/dev/null >> "$ALERT_FILE" || true
        alert=1
    fi

    return $alert
}

# =============================================================================
# MAIN
# =============================================================================
main() {
    log_info "=== VPS Watchdog started ==="

    local has_alerts=0

    check_miners || has_alerts=1
    check_suspicious_procs || has_alerts=1
    check_brute_force || has_alerts=1
    check_cpu || has_alerts=1
    check_ram || has_alerts=1
    check_load || has_alerts=1
    check_rootkit || has_alerts=1

    log_info "=== VPS Watchdog completed ==="

    # If there are alerts, output them
    if [ "$has_alerts" -eq 1 ] && [ -f "$ALERT_FILE" ]; then
        echo ""
        echo "⚠️  WATCHDOG ALERTS:"
        cat "$ALERT_FILE"
        return 1
    else
        log_info "✅ No threats detected"
        return 0
    fi
}

main "$@"
