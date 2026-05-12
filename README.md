# herd launcher config

Active config paths:

- Ghostty Herdr profile: `~/.config/ghostty/herdr`
- Herdr config: `~/.config/herdr/config.toml`

Add this to `~/.zshrc`:

```zsh
herd() {
  open -na Ghostty --args \
    --config-file="$HOME/.config/ghostty/herdr" \
    --command="$HOME/.local/bin/herdr"
}
```

Then run:

```zsh
source ~/.zshrc
herd
```

Key behavior in the Herdr Ghostty profile:

- `Cmd+N` new Herdr workspace
- `Cmd+T` new Herdr tab
- `Cmd+D` split right
- `Cmd+Shift+D` split down
- `Cmd+W` close pane
- `Cmd+↑/↓` previous/next workspace
- `Cmd+←/→` previous/next tab
- `Ctrl+arrows` focus panes

Reload notes:

- After editing `~/.config/herdr/config.toml`: `herdr server reload-config`
- After editing `~/.config/ghostty/herdr`: restart the Herdr Ghostty window

Packaged copies in this folder are snapshots for reference:

- `ghostty-herdr.conf`
- `herdr-config.toml`
- `herd.zsh`

Separate Dock app/icon note:

`herd` currently launches another instance of **Ghostty**.

Ghostty supports changing the macOS Dock/app-switcher icon from config:

```ini
# Built-in icon variant example
macos-icon = holographic

# Or a custom icon file
macos-icon = custom
macos-custom-icon = /Users/gustavocaiano/.config/ghostty/Herdr.icns
```

Put your icon file at `~/.config/ghostty/Herdr.icns` and add the two `macos-*` lines to `~/.config/ghostty/herdr` so only the Herdr-launched Ghostty profile gets a different icon.

Supported custom icon formats: PNG, JPEG, and ICNS. ICNS is recommended on macOS.

Changing the app name from **Ghostty** to **Herdr** is different: Ghostty does not expose a config option for the macOS app name. For a different Dock/app name, you need a separate app bundle (`Herdr.app`) with a different bundle name/identifier.
