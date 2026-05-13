#!/usr/bin/env bash
set -euo pipefail

APP_NAME="${APP_NAME:-Herdr}"
BUNDLE_ID="${BUNDLE_ID:-com.gustavocaiano.herdr}"
SOURCE_APP="${SOURCE_APP:-/Applications/Ghostty.app}"
TARGET_APP="${TARGET_APP:-$HOME/Applications/Herdr.app}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ICON_PATH="${ICON_PATH:-$REPO_DIR/assets/herdr.icns}"
GHOSTTY_PROFILE="${GHOSTTY_PROFILE:-$HOME/.config/ghostty/herdr}"
HERDR_BIN="${HERDR_BIN:-$HOME/.local/bin/herdr}"
FORCE="${FORCE:-0}"

log() { printf '[create-herdr-app] %s\n' "$*"; }
die() { printf '[create-herdr-app] error: %s\n' "$*" >&2; exit 1; }

[[ -d "$SOURCE_APP" ]] || die "source app not found: $SOURCE_APP"
[[ -f "$SOURCE_APP/Contents/MacOS/ghostty" ]] || die "source Ghostty executable not found"
[[ -f "$ICON_PATH" ]] || die "icon not found: $ICON_PATH"
[[ -f "$GHOSTTY_PROFILE" ]] || die "Ghostty Herdr profile not found: $GHOSTTY_PROFILE"
[[ -x "$HERDR_BIN" ]] || die "herdr binary not executable: $HERDR_BIN"

if [[ -d "$TARGET_APP" ]] && pgrep -f "$TARGET_APP/Contents/MacOS/(herdr-launcher|ghostty-bin|ghostty)" >/dev/null 2>&1; then
  if [[ "$FORCE" != "1" ]]; then
    die "$TARGET_APP appears to be running; close it first or run with FORCE=1"
  fi
fi

mkdir -p "$(dirname "$TARGET_APP")"
rm -rf "$TARGET_APP"
log "copying $SOURCE_APP -> $TARGET_APP"
cp -R "$SOURCE_APP" "$TARGET_APP"

PLIST="$TARGET_APP/Contents/Info.plist"
RESOURCES="$TARGET_APP/Contents/Resources"
MACOS="$TARGET_APP/Contents/MacOS"
ORIGINAL_BIN="$MACOS/ghostty"
RENAMED_BIN="$MACOS/ghostty-bin"
LAUNCHER="$MACOS/herdr-launcher"

log "patching Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleName $APP_NAME" "$PLIST"
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $APP_NAME" "$PLIST" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string $APP_NAME" "$PLIST"
/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $BUNDLE_ID" "$PLIST"
/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile $APP_NAME" "$PLIST" 2>/dev/null || /usr/libexec/PlistBuddy -c "Add :CFBundleIconFile string $APP_NAME" "$PLIST"
/usr/libexec/PlistBuddy -c "Set :CFBundleExecutable herdr-launcher" "$PLIST"

log "installing icon"
cp "$ICON_PATH" "$RESOURCES/$APP_NAME.icns"

log "installing launcher wrapper"
mv "$ORIGINAL_BIN" "$RENAMED_BIN"
cat > "$LAUNCHER" <<EOF
#!/usr/bin/env bash
set -euo pipefail
exec "\$(cd "\$(dirname "\$0")" && pwd)/ghostty-bin" \\
  --config-file="$GHOSTTY_PROFILE" \\
  --command="$HERDR_BIN" \\
  "\$@"
EOF
chmod +x "$LAUNCHER"

log "ad-hoc signing"
codesign --force --deep --sign - "$TARGET_APP" >/dev/null

log "validating signature"
codesign --verify --deep --strict "$TARGET_APP"

log "done: $TARGET_APP"
