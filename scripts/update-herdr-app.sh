#!/usr/bin/env bash
set -euo pipefail

SOURCE_APP="${SOURCE_APP:-/Applications/Ghostty.app}"
TARGET_APP="${TARGET_APP:-$HOME/Applications/Herdr.app}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STATE_DIR="$REPO_DIR/state"
LOG_PREFIX='[update-herdr-app]'

log() { printf '%s %s\n' "$LOG_PREFIX" "$*"; }
die() { printf '%s error: %s\n' "$LOG_PREFIX" "$*" >&2; exit 1; }

version_for_app() {
  local app="$1"
  local bin="$app/Contents/MacOS/ghostty"
  [[ -x "$app/Contents/MacOS/ghostty-bin" ]] && bin="$app/Contents/MacOS/ghostty-bin"
  [[ -x "$bin" ]] || return 1
  "$bin" +version | awk '/^- version:/ {print $3; exit}'
}

[[ -d "$SOURCE_APP" ]] || die "source app not found: $SOURCE_APP"
mkdir -p "$STATE_DIR"

source_version="$(version_for_app "$SOURCE_APP")"
target_version="missing"
if [[ -d "$TARGET_APP" ]]; then
  target_version="$(version_for_app "$TARGET_APP" 2>/dev/null || printf 'unknown')"
fi

log "source Ghostty version: $source_version"
log "target Herdr.app version: $target_version"

if [[ "$source_version" == "$target_version" ]]; then
  log "Herdr.app is up to date"
  printf '%s\n' "$source_version" > "$STATE_DIR/ghostty-version.txt"
  exit 0
fi

if [[ -d "$TARGET_APP" ]] && pgrep -f "$TARGET_APP/Contents/MacOS/(herdr-launcher|ghostty-bin|ghostty)" >/dev/null 2>&1; then
  log "Herdr.app is running; skipping update"
  exit 0
fi

log "recreating Herdr.app"
"$REPO_DIR/scripts/create-herdr-app.sh"
printf '%s\n' "$source_version" > "$STATE_DIR/ghostty-version.txt"
log "updated Herdr.app to Ghostty $source_version"
