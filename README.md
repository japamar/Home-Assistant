# Home-Assistant

This repository contains modular Home Assistant configuration focused on two self-contained packages:

1. **Garden Irrigation**
2. **Guest Mode**

## Repository structure

- `packages/garden/` — irrigation, weather calculations/data collection, notifications, and master controls.
- `packages/occupancy/` — guest mode package and globals.
- `lovelace/views/` — Lovelace view YAML for Garden and Guest Mode dashboards.
- `scripts/repo_audit.sh` — repository-level static audit script.
- `docs/REPO_MAINTENANCE.md` — maintenance and validation workflow.

## Validation and maintenance

Run a full static audit locally:

```bash
./scripts/repo_audit.sh
```

This checks for merge markers, YAML parse errors, whitespace issues in tracked diffs, and reports legacy templating usage.

For runtime validation in a Home Assistant-capable environment:

```bash
homeassistant --script check_config -c .
# or
hass --script check_config -c .
```

## Related repository

If you want to work specifically on the JavaScript irrigation integration, use:

- https://github.com/japamar/JS-HA-Irrigation-V3

Suggested setup:

```bash
git clone https://github.com/japamar/JS-HA-Irrigation-V3
cd JS-HA-Irrigation-V3
```
