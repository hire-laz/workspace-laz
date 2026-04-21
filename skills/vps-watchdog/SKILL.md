---
name: vps-watchdog
description: VPS security watchdog for Ubuntu. Monitors for cryptominers, malware, unusual processes, brute-force attacks, and high CPU/RAM. Runs every 30 minutes via cron. Alerts only on real threats or critically high resource usage.
---

# VPS Watchdog

Security and resource monitor for the Ubuntu VPS. Runs every 30min, alerts only on confirmed threats or critically high resource usage.

## What It Checks

1. **Cryptominers** — known miner process names + high CPU on unknown processes
2. **Suspicious processes** — unexpected root processes, hidden PIDs, unknown high-CPU procs
3. **Malware indicators** — unexpected cron entries, new SUID binaries, outbound connections to known bad ports
4. **Brute-force attacks** — fail2ban status, SSH auth failures
5. **CPU usage** — alert only when sustained above 85% (not a spike)
6. **RAM usage** — alert only when above 90% used
7. **Rootkit indicators** — /proc vs ps discrepancy, unexpected kernel modules

## Alert Thresholds (No False Positives)

| Metric | Alert Threshold | Notes |
|--------|----------------|-------|
| CPU | >85% sustained | Checked 3x over 15s — single spike is ignored |
| RAM | >90% used | Excludes buffer/cache (Linux reports it as "used") |
| Load avg | >3x num CPUs | For 4-core VPS: >12 sustained |
| Miner procs | Any match | Known miner names: xmrig, minerd, cpuminer, etc |
| SSH failures | >50 in 10min | fail2ban handles banning, we alert on volume |

## Script Location

`~/.openclaw/workspace/skills/vps-watchdog/scripts/watchdog.sh`

## Cron

Runs every 30 minutes via OpenClaw cron as isolated agentTurn.
Cron name: `vps-watchdog`
