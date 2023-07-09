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

Flash the image to SD card or USB disk, then boot. SSH access should work out of
the box.

- Tailscale: `sudo tailscale up`
- Home assistant: Install backup to `~/home-assistant` by extracting the
`backup.tar` file into the directory
- Nextcloud:
  - Restore postgres database backup (see below)
  - Restore `nextcloud` folder
  - Restore nginx certs and password files
- Adguard home:
  - Set up login (instructions in `adguard.nix`)
- Grafana:
  - For a new install admin password is `admin`.
- ha-relay: Set up access token (copy file)
- Rezepte server: Set up venv, copy vue stuff

## Backups

### Swift

Can be started via the systemd user service.

```sh
sudo systemctl start backup.mount
systemctl --user start backup-swift.service
```

### Raspberry Pis

Run backups for Home Assistant and Nextcloud at night if applicable.

### Nextcloud Database (manual backup)

See also [the official docs](https://docs.nextcloud.com/server/latest/admin_manual/maintenance/restore.html).

```bash
# Create backup
sudo -u postgres pg_dump nextcloud -f /tmp/nextcloud-db_`date +"%Y%m%d"`.bak
# Restore from backup
sudo -u postgres psql -d template1 -c "DROP DATABASE \"nextcloud\";"
sudo -u postgres psql -d template1 -c "CREATE DATABASE \"nextcloud\";"
sudo -u postgres psql -d nextcloud -f nextcloud-db_000000.bak
```
