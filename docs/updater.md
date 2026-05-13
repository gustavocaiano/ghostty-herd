# Updater diário

O updater compara a versão de `/Applications/Ghostty.app` com a versão da cópia `~/Applications/Herdr.app`.

Se forem diferentes, recria `Herdr.app` usando `scripts/create-herdr-app.sh`.

Por segurança, se `Herdr.app` estiver aberta, o updater faz skip e tenta novamente na próxima execução.

## Instalar LaunchAgent

```bash
mkdir -p "$HOME/Library/LaunchAgents"
mkdir -p "$HOME/.config/herd/logs" "$HOME/.config/herd/state"
cp ~/.config/herd/launchd/com.gustavocaiano.herdr-app-updater.plist "$HOME/Library/LaunchAgents/"
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.gustavocaiano.herdr-app-updater.plist"
```

## Correr agora manualmente

```bash
launchctl kickstart -k "gui/$(id -u)/com.gustavocaiano.herdr-app-updater"
```

## Desinstalar

```bash
launchctl bootout "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.gustavocaiano.herdr-app-updater.plist"
rm "$HOME/Library/LaunchAgents/com.gustavocaiano.herdr-app-updater.plist"
```

## Logs e estado

```text
~/.config/herd/logs/updater.out.log
~/.config/herd/logs/updater.err.log
~/.config/herd/state/ghostty-version.txt
```
