# mac-setup

## Install

```bash
brew bundle --file=Brewfile
mkdir -p ~/.config/aerospace
ln -sfn "$PWD/aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml
```

## Apps

- **Raycast** — Spotlight replacement. To bind to ⌘Space: System Settings → Keyboard → Keyboard Shortcuts → Spotlight → uncheck "Show Spotlight search", then set ⌘Space as the Raycast hotkey.
- **AeroSpace** — tiling window manager. Needs Accessibility permission. Config: `aerospace/aerospace.toml` (AeroSpace default, with `start-at-login = true`).
- **Vorssaint** — menu bar toolkit (keep-awake, system monitor, volume mixer).

## AeroSpace keys (default)

| Keys | Action |
|---|---|
| `alt-h/j/k/l` | Focus left/down/up/right |
| `alt-shift-h/j/k/l` | Move window |
| `alt-1..9`, `alt-a..z` | Switch workspace |
| `alt-shift-1..9` | Move window to workspace |
| `alt-/` | Toggle tiles layout |
| `alt-,` | Toggle accordion layout |
| `alt-tab` | Previous workspace |
| `alt-shift-;` | Service mode (`r` reset layout, `f` float/tile, `esc` reload config) |
