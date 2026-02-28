#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[1/4] Checking unresolved merge markers..."
if rg -n "^<<<<<<<|^=======|^>>>>>>>" --glob '*.yaml' .; then
  echo "ERROR: Unresolved merge markers found."
  exit 1
fi

echo "[2/4] Parsing all YAML files with Ruby Psych..."
ruby - <<'RUBY'
require 'yaml'
errors=[]
Dir.glob('**/*.yaml').sort.each do |f|
  begin
    YAML.safe_load(File.read(f), aliases: true)
  rescue => e
    errors << "#{f}: #{e.class}: #{e.message}"
  end
end
if errors.empty?
  puts 'YAML parse: OK'
else
  puts errors.join("\n")
  exit 1
end
RUBY

echo "[3/4] Checking for invalid line endings and whitespace in tracked changes..."
# --check returns non-zero only if there are whitespace issues in current diff.
git -c core.whitespace=cr-at-eol diff --check >/dev/null || {
  echo "WARNING: whitespace issues detected in current working tree diff"
  git -c core.whitespace=cr-at-eol diff --check || true
}

echo "[4/4] Reporting legacy templating usage (informational)..."
rg -n "data_template:|service_template:" packages lovelace || true

echo "Audit complete."
