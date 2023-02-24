# dotfiles

Install system settings:

```bash
nixos-rebuild switch --use-remote-sudo --flake .#<hostname>
```

For pascal:

```bash
nixos-rebuild switch --use-remote-sudo --flake .#pascal --target-host pascal
```

Update:

```bash
nix flake update
```

Manual steps after new desktop install:

- Configure gnome basics in `gnome-tweaks`
- Configure gnome extensions in gnome extensions app (enable & configure)
- Set up keyboard shortcuts
- Install bookmarks
- Install browser extensions
