{ ... }:

{
  nix.settings = {
    substituters = [
      "http://binary-cache-v2.vpn.cyberus-technology.de"
      "https://cache.nixos.org"
    ];
    trusted-public-keys = [
      "cyberus-1:0jjMD2b+guloGW27ZToxDQApCoWj+4ONW9v8VH/Bv0Q="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
}
