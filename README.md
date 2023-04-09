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

Backups:

Started automatically via udev rules when the correct disk is plugged in.
Or manually via the systemd user service.

```sh
sudo systemctl start backup.mount
systemctl --user start backup-swift.service
```
