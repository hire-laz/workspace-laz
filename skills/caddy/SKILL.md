---
name: caddy
description: Reverse proxy and port management for VPS (62.238.6.59). Allocate ports (3000-3200), deploy apps, manage Caddy config. Automatic port registry and config reloading.
---

# Caddy — Reverse Proxy + Port Management

Manage Caddy reverse proxy and auto-allocate ports for VPS deployments.

## VPS Configuration

- **VPS IP**: 62.238.6.59
- **Port Range**: 3000–3200 (200 apps max)
- **Config Path**: `/etc/caddy/Caddyfile` or `/etc/caddy/conf.d/apps.caddy`
- **Service**: `systemctl reload caddy`

## Port Registry

Stored at: `~/.openclaw/workspace/skills/caddy/port-registry.json`

```json
{
  "vps": "62.238.6.59",
  "range": [3000, 3200],
  "allocated": {
    "3000": { "app": "my-app", "status": "running", "createdAt": "2026-04-21T18:38:00Z" },
    "3001": { "app": "api-server", "status": "running", "createdAt": "2026-04-21T18:39:00Z" }
  }
}
```

## Usage

### Allocate a Port

```bash
caddy allocate <app-name>
# Output: { "port": 3002, "vps": "62.238.6.59" }
```

### Deploy an App

```bash
caddy deploy <app-name> <local-port>
# Steps:
# 1. Find free port from registry
# 2. Write Caddy reverse proxy block
# 3. Reload Caddy
# 4. Verify app is live

# Example:
caddy deploy my-app 3000
# Creates reverse proxy for 62.238.6.59:3000 → localhost:3000
```

### List All Apps

```bash
caddy list
# Output: 
# App           Port  Status    Created
# my-app        3000  running   2026-04-21T18:38:00Z
# api-server    3001  running   2026-04-21T18:39:00Z
```

### Free a Port

```bash
caddy free <port>
# Removes from registry, reloads Caddy config
```

### Restart Caddy

```bash
sudo systemctl reload caddy
# Or: sudo systemctl restart caddy
```

## Caddy Config Pattern

The skill generates blocks like this:

```
# /etc/caddy/conf.d/apps.caddy
62.238.6.59:3000 {
    reverse_proxy localhost:3000
}

62.238.6.59:3001 {
    reverse_proxy localhost:3001
}
```

Or with domain names (if configured):

```
myapp.example.com {
    reverse_proxy localhost:3000
}
```

## Deployment Workflow

1. **Build the app locally**
   ```bash
   npm run build
   ```

2. **Test locally**
   ```bash
   npm start  # runs on localhost:3000
   ```

3. **Allocate port on VPS**
   ```bash
   caddy allocate my-app
   # → Port 3002
   ```

4. **Copy to VPS** (via SSH/rsync)
   ```bash
   rsync -avz ~/Projects/my-app laz@62.238.6.59:/home/laz/deployed/
   ```

5. **Start app on VPS**
   ```bash
   ssh laz@62.238.6.59 'cd /home/laz/deployed/my-app && npm start'
   ```

6. **Reload Caddy** (automatic via caddy deploy)
   ```bash
   caddy deploy my-app 3002
   # → App is now live at 62.238.6.59:3002
   ```

7. **Verify**
   ```bash
   curl http://62.238.6.59:3002
   ```

## Health Checks

The skill can verify app is up:

```bash
caddy verify <app> <port>
# Returns: { "status": "up", "responseTime": "45ms" }
```

## Integration with Coding Agent

When coding-agent builds a web app:

1. Detects Next.js + web-stack
2. Auto-includes caddy context for VPS deployment
3. Runs `npm run build`
4. On deploy: calls caddy skill
5. Auto-allocates port + configures reverse proxy
6. Provides live URL in output

## Troubleshooting

### Caddy not reloading?
```bash
sudo systemctl status caddy
sudo systemctl restart caddy
sudo journalctl -u caddy -n 50
```

### Port already in use?
```bash
lsof -i :3000  # See what's using the port
kill -9 <PID>  # Force kill if needed
```

### Registry out of sync?
```bash
caddy refresh  # Rebuild registry from Caddy config
```

## Manual Caddy Config

If needed, edit Caddy directly:

```bash
sudo nano /etc/caddy/Caddyfile
# Then reload:
sudo systemctl reload caddy
```

## Notes

- Caddy is layer 7 (application), not layer 4 (transport) — perfect for HTTP/HTTPS
- Can add SSL/TLS later via Let's Encrypt
- Port range 3000–3200 is arbitrary — can be expanded if needed
- Registry is source of truth — Caddy config is generated from it
