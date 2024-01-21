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

## Desktop install with disko and nixos-anywhere

First off, check that you'll have some way to access your machine once the
installation is done (e.g. ssh daemon turned on and key configured, or initial
password).

In theory, nixos-anywhere is pretty much a one-click install. In practice, the
swift notebook still refuses to boot any NixOS stick in UEFI mode which makes
things more difficult.

### Workaround for booting into nixos installer

On target machine swift:

- Change BIOS setting to allow Legacy and UEFI boot mode
- Boot Ubuntu Live stick
- Change to tty3 with STRG+ALT+F3 to avoid Ubuntu GUI

```sh
# Install and enable openssh daemon
sudo apt install openssh-server
sudo systemctl start ssh
# Note ip address of this machine
ip addr
# Set password for user "ubuntu"
passwd
```

On source machine:

```sh
nix run github:nix-community/nixos-anywhere -- --flake '.#swift' ubuntu@<ip>
```

This will run kexec and then the target machine will boot into nixos.

### The actual install

On the installer at the target machine, login as user nixos and then:

```sh
# Create the password file for disk encryption
# -n is important so that echo does not create a newline
echo -n "password" > /tmp/secret.key
# Note down new ip address
ip addr
# Change root password
sudo su
passwd
```

On source machine:

```sh
nix run github:nix-community/nixos-anywhere -- --flake '.#swift' root@<other-ip>
```

This won't run kexec again because we're already in a nixos installer on the
target. It should then run disk formatting, install nixos and then reboot the
machine.

On swift, change BIOS settings back to UEFI only after the install.

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

### Raspi boot issues - 2023-11-01

So the Raspi 4 suddenly stopped booting. Several hours of debugging later and it
turns out that when two USB drives (the one with the OS and the backup drive)
are connected, the boot *sometimes* fails. When attaching a screen you can see
that the Raspi attempts to boot from network with various filenames.

Seems to be a U-Boot issue. The order in which the disks are discovered during
startup is not fixed and U-Boot only tries to boot the first usb storage disk it
finds. So when it finds the backup drive first, it won't manage to boot.

WIP Fix:

Attach screen and keyboard to Raspi, cancel boot process by hitting any key to
get to U-Boot command line.

```sh
U-Boot> printenv boot_targets
boot_targets=mmc0 mmc1 mmc2 usb0 pxe dhcp
U-Boot> printenv bootcmd_usb0
bootcmd_usb0=devnum=0; run usb_boot
U-Boot> printenv bootcmd_usb1
## Error: "bootcmd_usb1" not defined
U-Boot> usb storage
  Device 0: Vendor: .....
  Device 1: Vendor: .....
```

-> Only `usb0` is available as a boot target even though two disks are attached.
You can also reboot multiple times and see if the order changes. `usb list` is
another useful command and it can be executed with `usb list 0` as well.

```sh
U-Boot> setenv boot_targets 'mmc0 mmc1 mmc2 usb0 usb1 pxe dhcp'
U-Boot> setenv bootcmd_usb1 'devnum=1; run usb_boot'
U-Boot> saveenv ## This last step doesn't work yet, so we can't persist the config
Saving environment to FAT... Card did not respond to voltage select! : -110
** Bad device specification mmc 0 **
Failed (1)
```

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

### Dconf settings (manual)

```bash
# 1. Backup the existing settings
dconf dump / > dconf-settings.ini
# 2. Edit and manually remove everything that should not be transferred (e.g. window positions etc.)
vim dconf-settings.nix
# 3. Convert to nix
nix-shell -p dconf2nix --command "dconf2nix -i dconf-settings.ini -o dconf-settings.nix"
# 4. Compare and overwrite home-manager/dconf-settings.nix
```
