#!/usr/bin/env bash
# fetch-transcript.sh — Download and clean a YouTube transcript via yt-dlp
# Usage: ./fetch-transcript.sh "<youtube-url>"
# Output: cleaned plain text transcript to stdout

set -e

URL="${1:?Usage: fetch-transcript.sh <youtube-url>}"
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

cd "$TMPDIR"

yt-dlp \
  --write-subs \
  --write-auto-subs \
  --skip-download \
  --sub-format vtt \
  --sub-lang en \
  --quiet \
  "$URL"

VTT=$(ls *.vtt 2>/dev/null | head -1)

if [[ -z "$VTT" ]]; then
  echo "[ERROR] No subtitles found for: $URL" >&2
  exit 1
fi

# Clean VTT: strip WEBVTT header, timestamps, blank lines, deduplicate
grep -v "^WEBVTT" "$VTT" \
  | grep -v "^[0-9]\{2\}:" \
  | grep -v "^$" \
  | grep -v "^align:" \
  | sed 's/<[^>]*>//g' \
  | awk '!seen[$0]++' \
  | tr '\n' ' ' \
  | sed 's/  */ /g' \
  | sed 's/^ //;s/ $//'
echo
