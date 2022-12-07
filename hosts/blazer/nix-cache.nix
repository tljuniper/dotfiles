{ ... }:

{
  nix.settings = {
    trusted-substituters = [
      "https://cache.nixos.org"
      "http://binary-cache-v2.vpn.cyberus-technology.de"
      "https://binary-cache.vpn.cyberus-technology.de"
    ];
    trusted-public-keys = [
      "binary-cache.vpn.cyberus-technology.de:qhg25lVqyCT4sDOqxY6GJx8NF3F86eAJFCQjZK/db7Y="
      "cyberus-1:0jjMD2b+guloGW27ZToxDQApCoWj+4ONW9v8VH/Bv0Q="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
}
