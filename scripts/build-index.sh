#!/usr/bin/env bash
# Rebuild the README problem index and progress count from each problem's
# <problem-meta> metadata (read with `typst query`).
#   build-index.sh          rewrite README.md
#   build-index.sh --check  fail if README.md is out of date
# Needs typst and jq.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
README="$ROOT/README.md"
CHECK=0
[ "${1:-}" = "--check" ] && CHECK=1

require() {
  local cmd missing=0
  for cmd in "$@"; do
    command -v "$cmd" >/dev/null 2>&1 || { echo "error: $cmd not found" >&2; missing=1; }
  done
  [ "$missing" -eq 0 ] || exit 2
}

problem_files() {
  local root="$1" f base
  shopt -s nullglob
  for f in "$root"/problems/*.typ; do
    base="$(basename "$f")"
    [ "$base" = "_TEMPLATE.typ" ] && continue
    # Skip Thai siblings: they share their English file's number and would
    # otherwise show as a duplicate index row.
    case "$base" in *-th.typ) continue ;; esac
    printf '%s\n' "$f"
  done
  shopt -u nullglob
}

plural() { if [ "$1" -eq 1 ]; then printf '%s' "$2"; else printf '%s' "$3"; fi; }

require typst jq

rows=""
count=0
topics_all=""

while IFS= read -r f; do
  base="$(basename "$f")"
  num="$(printf '%s' "$base" | sed -E 's/^([a-z]+-[0-9]{3})-.*/\1/')"

  json="$(typst query --root "$ROOT" "$f" '<problem-meta>' --field value --one 2>/dev/null)" || {
    echo "error: failed to query $base (does it compile?)" >&2; exit 1;
  }

  title="$(printf '%s' "$json" | jq -r '.title')"
  source="$(printf '%s' "$json" | jq -r '.source // "-"')"
  source_url="$(printf '%s' "$json" | jq -r '.source_url // empty')"
  date="$(printf '%s' "$json" | jq -r '.date // "-"')"
  topics="$(printf '%s' "$json" | jq -r '(.tags // []) | join(", ")')"

  topics_all="$topics_all$topics, "

  src_cell="$source"
  [ -n "$source_url" ] && src_cell="[$source]($source_url)"

  rows="$rows| $num | $title | $topics | $src_cell | $date |
"
  count=$((count + 1))
done < <(problem_files "$ROOT")

if [ "$count" -eq 0 ]; then
  rows="| - | *No problems yet* | | | |
"
fi

# unique, sorted topics for the progress line
uniq_topics="$(printf '%s' "$topics_all" | tr ',' '\n' | sed 's/^ *//;s/ *$//;/^$/d' | sort -u | paste -sd '|' - | sed 's/|/, /g')"
if [ -z "$uniq_topics" ]; then uniq_topics="-"; fi

problem_word="$(plural "$count" problem problems)"

index_block="| # | Problem | Topics | Source | Solved |
|---|---------|--------|--------|--------|
$rows"

progress_block="- $count $problem_word solved
- Topics covered: $uniq_topics"

tmp="$(mktemp)"
awk -v idx="$index_block" -v prog="$progress_block" '
  /<!-- INDEX:START/    { print; print idx; skip=1; next }
  /<!-- INDEX:END/      { skip=0 }
  /<!-- PROGRESS:START/ { print; print prog; skip=1; next }
  /<!-- PROGRESS:END/   { skip=0 }
  skip { next }
  { print }
' "$README" > "$tmp"

if [ "$CHECK" -eq 1 ]; then
  if ! diff -q "$README" "$tmp" >/dev/null; then
    echo "README index is out of date. Run: make index" >&2
    diff "$README" "$tmp" >&2 || true
    rm -f "$tmp"
    exit 1
  fi
  rm -f "$tmp"
  echo "index up to date"
else
  mv "$tmp" "$README"
  echo "index rebuilt ($count $problem_word)"
fi
