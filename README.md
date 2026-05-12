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

`herd` currently launches another instance of **Ghostty**, so macOS still shows Ghostty in the Dock. A separate **Herdr.app** icon/name is possible, but it requires creating or copying a macOS app bundle with a different bundle name/identifier and launching Ghostty with this profile from that app. That is more invasive than config changes, so do it as a separate step.
