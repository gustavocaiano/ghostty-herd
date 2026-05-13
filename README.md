# Herd Ghostty profile

Configuração para usar **Herdr dentro do Ghostty** com atalhos estilo cmux/macOS, e opcionalmente criar uma mini app `Herdr.app` separada para Dock/shortcuts.

## Quick activation

1. Criar `Herdr.app`:

   ```bash
   ~/.config/herd/scripts/create-herdr-app.sh
   ```

2. Abrir a app:

   ```bash
   open -na "$HOME/Applications/Herdr.app"
   ```

3. Apontar o teu shortcut, por exemplo `Ctrl+3`, para:

   ```text
   ~/Applications/Herdr.app
   ```

4. Opcional: instalar o updater diário:

   ```bash
   mkdir -p "$HOME/Library/LaunchAgents"
   mkdir -p "$HOME/.config/herd/logs" "$HOME/.config/herd/state"
   cp ~/.config/herd/launchd/com.gustavocaiano.herdr-app-updater.plist "$HOME/Library/LaunchAgents/"
   launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.gustavocaiano.herdr-app-updater.plist"
   ```

Nota: como `Herdr.app` é uma cópia local modificada e assinada ad-hoc, o macOS pode mostrar um aviso na primeira abertura. Para uso local isto é esperado; se bloquear, abre uma vez com botão direito → **Open** ou permite em **Privacy & Security**.

## O que está neste repo

```text
assets/herdr.icns                         ícone arredondado para Herdr.app
ghostty-herdr.conf                        snapshot do profile Ghostty para Herdr
herdr-config.toml                         snapshot das keybindings Herdr
herd.zsh                                  função zsh simples
scripts/create-herdr-app.sh               cria/recria ~/Applications/Herdr.app
scripts/update-herdr-app.sh               atualiza Herdr.app quando Ghostty muda
launchd/com.gustavocaiano.herdr-app-updater.plist
docs/setup.md                             setup completo
docs/herdr-app.md                         detalhes da mini app
docs/updater.md                           updater diário via launchd
docs/troubleshooting.md                   notas e problemas conhecidos
```

## Caminhos ativos

- Ghostty profile usado pelo Herdr: `~/.config/ghostty/herdr`
- Config Herdr: `~/.config/herdr/config.toml`
- Mini app opcional: `~/Applications/Herdr.app`

## Setup rápido: função `herd`

Adiciona isto ao `~/.zshrc`:

```zsh
herd() {
  open -na Ghostty --args \
    --config-file="$HOME/.config/ghostty/herdr" \
    --command="$HOME/.local/bin/herdr"
}
```

Depois:

```zsh
source ~/.zshrc
herd
```

## Setup com app separada: `Herdr.app`

Para ter nome/ícone separados no Dock e apontar shortcuts diretamente para a app:

```bash
~/.config/herd/scripts/create-herdr-app.sh
```

Depois abre:

```bash
open -na "$HOME/Applications/Herdr.app"
```

Esta app é uma cópia local de `Ghostty.app` com:

- bundle name/display name: `Herdr`
- bundle id: `com.gustavocaiano.herdr`
- ícone: `assets/herdr.icns`
- launcher wrapper que inicia Ghostty com `--config-file ~/.config/ghostty/herdr --command ~/.local/bin/herdr`
- assinatura local ad-hoc (`codesign --sign -`)

## Atalhos

No profile Herdr:

- `Cmd+N` novo workspace Herdr
- `Cmd+T` novo tab Herdr
- `Cmd+D` split right
- `Cmd+Shift+D` split down
- `Cmd+W` fechar pane
- `Cmd+↑/↓` workspace anterior/seguinte
- `Cmd+←/→` tab anterior/seguinte
- `Ctrl+arrows` foco entre panes

## Updater diário opcional

Instala o LaunchAgent:

```bash
mkdir -p "$HOME/Library/LaunchAgents"
mkdir -p "$HOME/.config/herd/logs" "$HOME/.config/herd/state"
cp ~/.config/herd/launchd/com.gustavocaiano.herdr-app-updater.plist "$HOME/Library/LaunchAgents/"
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.gustavocaiano.herdr-app-updater.plist"
```

Ele corre diariamente e só recria `Herdr.app` se a versão de `/Applications/Ghostty.app` tiver mudado. Se `Herdr.app` estiver aberta, faz skip por segurança.

## Notas importantes

- `macos-icon` no Ghostty é app-wide para o bundle, não por janela/profile.
- Para ícone separado só no Herdr, usa `Herdr.app` separada.
- A app copiada é assinada localmente, não com a assinatura oficial da Ghostty.
- Isto é adequado para uso local; para distribuição pública seria necessário Developer ID/notarização.

Ver detalhes em `docs/setup.md`.
