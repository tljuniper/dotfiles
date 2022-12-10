# dotfiles

Install system settings:

```bash
nixos-rebuild switch --use-remote-sudo --flake .#<hostname>
```

For pascal both user and system settings are applied at the same time:

```bash
nixos-rebuild switch --use-remote-sudo --flake .#pascal --target-host pascal
```

Install user setttings:

```bash
./apply-users.sh
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
