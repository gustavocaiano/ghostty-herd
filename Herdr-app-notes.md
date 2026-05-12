# Herdr.app Dock icon/name options

Current launcher:

```zsh
open -na Ghostty --args --config-file="$HOME/.config/ghostty/herdr" --command="$HOME/.local/bin/herdr"
```

This opens another Ghostty instance.

## Icon-only option

Ghostty supports changing the macOS app icon via config. This affects the Dock and application switcher icon, not the Finder bundle icon.

Add one of these to `~/.config/ghostty/herdr`:

```ini
# Use one of Ghostty's built-in icon variants
macos-icon = holographic
```

or:

```ini
# Use a custom icon file
macos-icon = custom
macos-custom-icon = /absolute/path/to/Herdr.icns
```

Supported custom icon formats include PNG, JPEG, and ICNS. If `macos-custom-icon` is omitted, Ghostty defaults to `~/.config/ghostty/Ghostty.icns`.

This is the lightest way to visually distinguish the Herdr-launched Ghostty window.

## Name option

Ghostty does not expose a config option to change the macOS app name shown by the bundle. You can change terminal/window titles, but the Dock/app name remains Ghostty unless you create a separate app bundle.

To get a separate Dock name, the practical options are:

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
