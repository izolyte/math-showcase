#!/usr/bin/env bash
# Fill the topic lists in the docs from topics.txt.
#   sync-topics.sh          rewrite the marked regions
#   sync-topics.sh --check  fail if any of them is stale (CI)
#
# A region runs between a line with "TOPICS:START <format>" and "TOPICS:END".
# <format> picks how each topic is rendered:
#   table     | `prefix` | Name |
#   dropdown  - prefix (Name)
#   list      `prefix1 prefix2 ...`  (single line)
# Whatever indentation the START line has is applied to the emitted lines, so an
# indented YAML dropdown stays indented.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TOPICS="$ROOT/topics.txt"
CHECK=0
[ "${1:-}" = "--check" ] && CHECK=1

# Files that carry TOPICS markers.
TARGETS=(
  "README.md"
  "docs/CONVENTIONS.md"
)

# Render the three block formats from topics.txt.
parse() { awk 'NF && $1 !~ /^#/ { name=$0; sub(/^[ \t]*[^ \t]+[ \t]+/, "", name); print $1 "\t" name }' "$TOPICS"; }

table_block="| Prefix | Topic |
|--------|-------|
"; dropdown_block=""; prefixes=""
while IFS=$'\t' read -r prefix name; do
  table_block="$table_block| \`$prefix\` | $name |
"
  dropdown_block="$dropdown_block- $prefix ($name)
"
  prefixes="$prefixes$prefix "
done < <(parse)
list_block="\`${prefixes% }\`"

# Strip trailing newline from the multi-line blocks.
table_block="${table_block%$'\n'}"
dropdown_block="${dropdown_block%$'\n'}"

rc=0
for rel in "${TARGETS[@]}"; do
  file="$ROOT/$rel"
  [ -f "$file" ] || { echo "warn: $rel not found, skipping" >&2; continue; }

  tmp="$(mktemp)"
  awk -v table="$table_block" -v dropdown="$dropdown_block" -v list="$list_block" '
    /TOPICS:START/ {
      print
      # format token = first word after TOPICS:START
      tok = $0; sub(/.*TOPICS:START[ \t]+/, "", tok); sub(/[ \t].*/, "", tok)
      # indent = leading whitespace of the START line
      ind = $0; sub(/[^ \t].*/, "", ind)
      block = (tok == "table") ? table : (tok == "dropdown") ? dropdown : list
      n = split(block, lines, "\n")
      for (i = 1; i <= n; i++) print ind lines[i]
      skip = 1; next
    }
    /TOPICS:END/ { skip = 0 }
    skip { next }
    { print }
  ' "$file" > "$tmp"

  if [ "$CHECK" -eq 1 ]; then
    if ! diff -q "$file" "$tmp" >/dev/null; then
      echo "out of date: $rel (run: make topics)" >&2
      diff "$file" "$tmp" >&2 || true
      rc=1
    fi
    rm -f "$tmp"
  else
    if diff -q "$file" "$tmp" >/dev/null; then
      rm -f "$tmp"
    else
      mv "$tmp" "$file"
      echo "updated $rel"
    fi
  fi
done

if [ "$CHECK" -eq 1 ]; then
  [ "$rc" -eq 0 ] && echo "topics in sync"
  exit "$rc"
fi
echo "topics synced"
