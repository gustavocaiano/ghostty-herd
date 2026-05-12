# Paste this into ~/.zshrc or source this file.

herd() {
  open -na Ghostty --args \
    --config-file="$HOME/.config/ghostty/herdr" \
    --command="$HOME/.local/bin/herdr"
}
