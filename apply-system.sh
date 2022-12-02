#!/bin/sh
set -euo pipefail
pushd ~/dotfiles
nixos-rebuild --use-remote-sudo switch --flake .#raspi
popd
