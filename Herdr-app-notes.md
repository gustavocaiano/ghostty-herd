# Herdr.app Dock icon/name options

Direct Ghostty launcher:

```zsh
open -na Ghostty --args --config-file="$HOME/.config/ghostty/herdr" --command="$HOME/.local/bin/herdr"
```

This opens another Ghostty instance.

Recommended launcher when `Herdr.app` exists:

```zsh
open -na "$HOME/Applications/Herdr.app"
```

## Icon-only option

Ghostty supports changing the macOS app icon via config. This affects the Dock and application switcher icon, not the Finder bundle icon.

Important limitation: this is application-level for the Ghostty bundle, not per window/profile. If regular Ghostty and Herdr are both running from `Ghostty.app`, setting `macos-icon` in the Herdr profile can make all running Ghostty Dock/app-switcher icons use the same icon.

Add one of these to `~/.config/ghostty/herdr`:

```ini
# Use one of Ghostty's built-in icon variants
macos-icon = holographic
```

or:

```ini
# Use a custom icon file
macos-icon = custom
macos-custom-icon = /Users/gustavocaiano/.config/ghostty/Herdr.icns
```

Put your icon file at `~/.config/ghostty/Herdr.icns` for the path above.

Supported custom icon formats include PNG, JPEG, and ICNS. ICNS is recommended on macOS. If `macos-custom-icon` is omitted, Ghostty defaults to `~/.config/ghostty/Ghostty.icns`.

This is useful only if you are okay with Ghostty as an app using that icon while the config is active. It is not a reliable way to give only the Herdr-launched window its own Dock icon.

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
