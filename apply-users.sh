#!/bin/sh
set -euo pipefail
pushd ~/dotfiles
nix build .#homeManagerConfigurations.juniper.activationPackage
./result/activate
popd
