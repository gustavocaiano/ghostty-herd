# Herdr.app Dock icon/name options

Current launcher:

```zsh
open -na Ghostty --args --config-file="$HOME/.config/ghostty/herdr" --command="$HOME/.local/bin/herdr"
```

This opens another Ghostty instance, so the Dock still shows Ghostty.

To get a separate Dock name/icon, the practical options are:

1. **Copy Ghostty.app to Herdr.app**
   - Copy `/Applications/Ghostty.app` to `~/Applications/Herdr.app`.
   - Change `CFBundleName`, `CFBundleDisplayName`, and `CFBundleIdentifier` in `Info.plist`.
   - Optionally replace the app icon.
   - Re-sign the copied app ad-hoc.
   - Launch it with the same `--config-file` and `--command` arguments.

2. **Create a wrapper app**
   - Easier, but usually the wrapper launches Ghostty and exits.
   - The running terminal still appears as Ghostty unless the wrapper stays open, which can leave two Dock icons.

Recommendation: use the config launcher first. If you want the separate Dock identity, create a copied `Herdr.app` as a separate task because it modifies an app bundle and may need re-signing after Ghostty updates.
