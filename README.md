thanks @vamshi uncle

## Window manager

[rishabhwm](https://github.com/rishabh-tole/rishabhwm) is included as a submodule (`rishabhwm/`).
`mac_config.sh` builds and installs it, and links `rishabhwm-config/` to `~/.config/rishabhwm`.
Allow it under System Settings → Privacy & Security → Accessibility after install.

Update to the latest rishabhwm:

```bash
git submodule update --remote rishabhwm && ./rishabhwm/scripts/install.sh
```

## Hammerspoon

`hammerspoon/` is linked to `~/.hammerspoon` by `mac_config.sh`.

- `vivaldi-tabswipe.lua` - 2-finger swipe left/right = prev/next tab, Vivaldi only. Vivaldi's own swipe-back is disabled per-app (`defaults write com.vivaldi.Vivaldi AppleEnableSwipeNavigateWithScrolls -bool false`) so other apps still swipe between pages
- needs Accessibility permission, and Vivaldi → Settings → Tabs → Tab Cycling → Cycle in Tab Order
- tune `THRESHOLD` / `RATIO` at the top of the file, then menu bar → Reload Config
