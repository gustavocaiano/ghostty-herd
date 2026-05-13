# Paste this into ~/.zshrc or source this file.

herd() {
  local app="$HOME/Applications/Herdr.app"
  local bundle_id="com.gustavocaiano.herdr"

  if pgrep -f "$app/Contents/MacOS/(herdr-launcher|ghostty-bin)" >/dev/null 2>&1; then
    osascript -e "tell application id \"$bundle_id\" to activate" >/dev/null 2>&1 || open "$app"
  else
    open "$app"
  fi
}
