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

## Manual steps after new desktop install

- Configure gnome basics in `gnome-tweaks`
- Configure gnome extensions in gnome extensions app (enable & configure)
- Set up keyboard shortcuts
- Install bookmarks
- Install browser extensions

## Manual steps for a new Raspberry install

Building an SD card image for Raspberry:

```bash
nix build --flake .#nixosConfigurations.rust.config.system.build.sdImage
```

Flash the image to SD card or USB disk, plug in another disk labeled `backup`,
then boot. SSH access should work out of the box.

- Tailscale: Maybe remove other device first, then `sudo tailscale up`
- Home assistant: Install backup to `~/home-assistant`
- Nextcloud: Restore nginx certs and password files, install backup
- Adguard home: Set up login (instructions in `adguard.nix`)
- Grafana: Set up login
- ha-relay: Set up access token
- Rezepte server: Set up venv, copy vue stuff

## Backups

Started automatically via udev rules when the correct disk is plugged in.
Or manually via the systemd user service.

```sh
sudo systemctl start backup.mount
systemctl --user start backup-swift.service
```
