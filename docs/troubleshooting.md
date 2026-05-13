# Troubleshooting

## O ícone mudou também na Ghostty normal

`macos-icon` é app-wide para o bundle Ghostty. Não é por janela/profile. Remove `macos-icon` do profile se não quiseres esse comportamento, ou usa `Herdr.app` separada.

## `Cmd+↑` fica preso no UI `ctrl+b`

Não uses `ctrl+b + arrow` para navegação persistente; Herdr mantém o navigate mode ativo. A config deste repo usa bindings diretos:

```toml
previous_workspace = "ctrl+up"
next_workspace = "ctrl+down"
```

e Ghostty traduz `Cmd+↑/↓` para `Ctrl+↑/↓`.

## `Herdr.app` não abre Herdr

Recria a app:

```bash
~/.config/herd/scripts/create-herdr-app.sh
```

Depois abre diretamente:

```bash
open -na "$HOME/Applications/Herdr.app"
```

## macOS diz que a app não é verificada

A cópia é assinada localmente/ad-hoc. Para uso pessoal, normalmente basta abrir explicitamente uma vez pelo Finder ou permitir em Privacy & Security se o macOS bloquear.

## Depois de atualizar Ghostty, Herdr.app ficou antiga

Corre:

```bash
~/.config/herd/scripts/update-herdr-app.sh
```

Ou instala o updater diário em `docs/updater.md`.
