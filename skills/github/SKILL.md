---
name: github
description: GitHub CLI operations for hire-laz organization. Use for creating repos, managing PRs, issues, workflow status, pushing code, managing branches. Authenticated via gh CLI with PAT token for coderaven account.
---

# GitHub Skill — hire-laz Organization

Use `gh` CLI for all GitHub operations within the hire-laz organization.

## Authentication Status

- ✅ **CLI installed:** `gh` v2.90.0
- ✅ **Authenticated as:** coderaven
- ✅ **Org access:** hire-laz (admin role)
- ⚠️ **PAT scope limitation:** Current token lacks explicit `repo` write scope. Can create repos and read, but push via git requires `repo` scope.
- **Workaround:** Use only `gh` CLI commands for push/pull operations when available

## Configuration

```bash
# Already configured
gh auth status
# github.com
#   ✓ Logged in to github.com account coderaven
#   ✓ Active account: true
```

## Core Commands

### Repos

```bash
# List repos in org
gh repo list hire-laz

# View repo
gh repo view hire-laz/workspace-laz

# Create repo (recommended: in org)
gh repo create hire-laz/new-repo --description "..." --public

# Delete repo
gh repo delete hire-laz/old-repo --yes

# Clone repo
gh repo clone hire-laz/workspace-laz
```

### Issues & PRs

```bash
# Create issue
gh issue create --repo hire-laz/workspace-laz --title "..." --body "..."

# List issues
gh issue list --repo hire-laz/workspace-laz

# Create PR
gh pr create --repo hire-laz/workspace-laz --title "..." --body "..."

# Merge PR
gh pr merge 123 --repo hire-laz/workspace-laz --merge

# View PR checks
gh pr checks 123 --repo hire-laz/workspace-laz
```

### Workflows

```bash
# List workflow runs
gh run list --repo hire-laz/workspace-laz

# View workflow logs
gh run view 12345 --repo hire-laz/workspace-laz --log

# Trigger workflow manually
gh workflow run deploy.yml --repo hire-laz/workspace-laz
```

## Git Integration

### Push via gh CLI (recommended for now)

Due to PAT scope limitation, use:

```bash
cd /path/to/repo
gh repo sync hire-laz/workspace-laz --source master
```

Or commit locally, then push via HTTP with explicit auth:

```bash
# NOT recommended (token in URL) — use gh instead
git push https://token@github.com/hire-laz/repo.git master
```

### SSH Setup (alternative)

If SSH key is configured:
```bash
git remote set-url origin git@github.com:hire-laz/repo.git
git push origin master
```

## Org-Level Operations

```bash
# List org members
gh api orgs/hire-laz/members

# View membership
gh api orgs/hire-laz/memberships/coderaven

# List org teams
gh api orgs/hire-laz/teams

# Check org permissions
gh api orgs/hire-laz --jq '{login:.login,public_repos:.public_repos}'
```

## Known Limitations

| Limitation | Reason | Workaround |
|---|---|---|
| Can't push via git | PAT missing `repo` scope | Use `gh` commands, or request new PAT with full scope |
| No SSH key configured | Not set up yet | Set up SSH key pair and add to github.com |

## Future Setup

Once PAT scope is fixed:
```bash
# Re-auth with new token
gh auth login --with-token <<< 'new_pat_with_repo_scope'
gh auth setup-git
```

Then normal git push will work.
