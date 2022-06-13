#!/usr/bin/env bash
set -euo pipefail
pushd ~/dotfiles
nix build .#homeManagerConfigurations.$USERNAME.activationPackage
./result/activate
popd
