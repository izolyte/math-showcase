#!/usr/bin/env bash
# Scaffold a new problem file from the template.
#
#   new-problem.sh <topic> <slug>
#
# Computes the next zero-padded number for the topic, copies _TEMPLATE.typ,
# and prints the new file path.

set -euo pipefail

# valid topics come from topics.txt
. "$(dirname "$0")/topics.sh"
VALID_TOPICS="$(topic_list)"

usage() {
  echo "Usage: $0 <topic> <slug>" >&2
  echo "  topic: one of: $VALID_TOPICS" >&2
  echo "  slug : kebab-case, e.g. gamma-integral" >&2
  exit 1
}

[ $# -eq 2 ] || usage
TOPIC="$1"
SLUG="$2"

# Validate topic
case " $VALID_TOPICS " in
  *" $TOPIC "*) ;;
  *) echo "error: invalid topic '$TOPIC'" >&2; usage ;;
esac

# Validate slug (lowercase, digits, hyphens)
case "$SLUG" in
  *[!a-z0-9-]*) echo "error: slug must be lowercase letters, digits, hyphens" >&2; exit 1 ;;
esac

# Resolve repo root (one level up from scripts/)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PROBLEMS="$ROOT/problems"
TEMPLATE="$PROBLEMS/_TEMPLATE.typ"

[ -f "$TEMPLATE" ] || { echo "error: $TEMPLATE not found" >&2; exit 1; }

# Find highest existing number for this topic
MAX=0
for f in "$PROBLEMS/$TOPIC"-[0-9][0-9][0-9]-*.typ; do
  [ -e "$f" ] || continue
  base="$(basename "$f")"
  num="${base#"$TOPIC"-}"
  num="${num%%-*}"
  num=$((10#$num))
  [ "$num" -gt "$MAX" ] && MAX="$num"
done

NEXT="$(printf '%03d' $((MAX + 1)))"
TARGET="$PROBLEMS/$TOPIC-$NEXT-$SLUG.typ"

[ -e "$TARGET" ] && { echo "error: $TARGET already exists" >&2; exit 1; }

cp "$TEMPLATE" "$TARGET"

echo "Created: problems/$TOPIC-$NEXT-$SLUG.typ"
echo "Next:    fill metadata + solution, then 'make $TOPIC-$NEXT'"
