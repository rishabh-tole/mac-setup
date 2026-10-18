thanks @vamshi uncle

## Window manager

[rishabhwm](https://github.com/rishabh-tole/rishabhwm) is included as a submodule (`rishabhwm/`).
`mac_config.sh` builds and installs it, and links `rishabhwm-config/` to `~/.config/rishabhwm`.
Allow it under System Settings → Privacy & Security → Accessibility after install.

Update to the latest rishabhwm:

```bash
git submodule update --remote rishabhwm && ./rishabhwm/scripts/install.sh
```
