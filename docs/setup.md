# Setup completo

## 1. Aplicar configs ativas

Copiar o profile Ghostty:

```bash
cp ~/.config/herd/ghostty-herdr.conf ~/.config/ghostty/herdr
```

Copiar a config Herdr:

```bash
cp ~/.config/herd/herdr-config.toml ~/.config/herdr/config.toml
herdr server reload-config
```

## 2. Escolher modo de lançamento

### Opção A — função zsh para `Herdr.app`

Adicionar ao `~/.zshrc`:

```zsh
source "$HOME/.config/herd/herd.zsh"
```

Usar:

```zsh
herd
```

Esta função usa `Herdr.app`, portanto requer criar a app uma vez com `scripts/create-herdr-app.sh`.

### Opção B — abrir a mini app `Herdr.app` diretamente

Criar app separada:

```bash
~/.config/herd/scripts/create-herdr-app.sh
```

Abrir:

```bash
open -na "$HOME/Applications/Herdr.app"
```

Esta é a opção recomendada para shortcuts como `Ctrl+3`, porque macOS vê `Herdr.app` como app separada.

## 3. Atualizar quando Ghostty atualizar

Manual:

```bash
~/.config/herd/scripts/update-herdr-app.sh
```

Automático diário: ver `docs/updater.md`.
