# Herdr.app

`Herdr.app` é uma cópia local de `/Applications/Ghostty.app` modificada para lançar Herdr diretamente.

## O que o script altera

`scripts/create-herdr-app.sh` faz:

1. Copia `/Applications/Ghostty.app` para `~/Applications/Herdr.app`.
2. Altera `Info.plist`:
   - `CFBundleName = Herdr`
   - `CFBundleDisplayName = Herdr`
   - `CFBundleIdentifier = com.gustavocaiano.herdr`
   - `CFBundleIconFile = Herdr`
   - remove `CFBundleIconName = Ghostty`, para o macOS não preferir o ícone antigo do asset catalog
3. Copia `assets/herdr.icns` para `Contents/Resources/Herdr.icns`.
4. Renomeia o binário original para `ghostty-bin`.
5. Compila um launcher nativo `Contents/MacOS/herdr-launcher` que executa:

```bash
ghostty-bin --config-file "$HOME/.config/ghostty/herdr" --command "$HOME/.local/bin/herdr"
```

6. Assina a app localmente com `codesign --force --deep --sign -`.

Nota: o launcher é compilado com `/usr/bin/clang`, por isso precisas das Xcode Command Line Tools instaladas.

O launcher também limpa variáveis `HERDR_*` herdadas, para permitir abrir `Herdr.app` mesmo quando o comando é executado a partir de um pane já dentro do Herdr.

## Vantagens

- Dock/app switcher separado.
- Shortcuts podem apontar diretamente para `Herdr.app`.
- Ícone Herdr sem afetar a Ghostty normal.
- Normal Ghostty continua independente.

## Desvantagens

- Depois de atualizar Ghostty, convém recriar `Herdr.app`.
- A assinatura oficial da Ghostty não é preservada; a cópia fica com assinatura local ad-hoc.
- Permissões macOS podem ser separadas da Ghostty normal.

## Segurança

O script não baixa binários. Ele só copia a tua `/Applications/Ghostty.app`, modifica a cópia local e assina localmente. Para uso pessoal/local, isto é razoável. Para distribuir a app, seria necessário assinatura Developer ID e notarização.
