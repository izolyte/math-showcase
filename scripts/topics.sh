#!/usr/bin/env bash
# Read topic prefixes from topics.txt.
#   topics.sh list    -> calc linalg alg ...
#   topics.sh regex   -> calc|linalg|alg|...
# Can also be sourced for topic_list / topic_regex.

_topics_file() {
  local here
  here="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)"
  printf '%s/topics.txt' "$here"
}

_topic_prefixes() {
  awk 'NF && $1 !~ /^#/ { print $1 }' "$(_topics_file)"
}

topic_list()  { _topic_prefixes | paste -sd ' ' - ; }
topic_regex() { _topic_prefixes | paste -sd '|' - ; }

if [ "${BASH_SOURCE[0]:-$0}" = "$0" ]; then
  case "${1:-}" in
    list)  topic_list ;;
    regex) topic_regex ;;
    *) echo "usage: $0 {list|regex}" >&2; exit 1 ;;
  esac
fi
