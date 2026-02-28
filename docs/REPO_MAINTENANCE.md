# Repository Maintenance Guide

This repository stores Home Assistant package YAML and Lovelace views.

## Quick audit

Run the local audit script from repository root:

```bash
./scripts/repo_audit.sh
```

The script validates:

1. No unresolved merge conflict markers in `*.yaml` files.
2. YAML parse validity for all `*.yaml` files using Ruby Psych.
3. Whitespace issues in current tracked diff.
4. A report of legacy `data_template` / `service_template` usage (informational only).

## Optional Home Assistant runtime validation

If `homeassistant`/`hass` is installed in your environment, run:

```bash
homeassistant --script check_config -c .
# or
hass --script check_config -c .
```

## Suggested workflow

1. Run `./scripts/repo_audit.sh` before committing.
2. Validate Home Assistant config in a HA-capable environment.
3. If changing automations/scripts, test one manual run and one scheduled run path.
