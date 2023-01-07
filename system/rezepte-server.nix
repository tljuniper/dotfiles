{ pkgs, ... }:

{
  # TODOs:
  # - derivation for server
  # --> dependencies in derivation
  # --> automatic download of sources
  # --> setup.py
  # --> systemd service in derivation

  # (currently contents of the venv have to be set up manually -- see
  # webapp/server/README.md for instructions)

  environment.systemPackages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
  ];

  systemd.services.rezepte-server = {
    description = "Backend for recipe app that connects to Bring!";
    after = ["network.target"];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "juniper";
      WorkingDirectory = "/home/juniper/Rezepte/webapp/server";
      ExecStart = "/home/juniper/Rezepte/webapp/server/env/bin/python3 app.py";
      Restart= "always";
    };
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts."essensplaner" = {
    root = "/var/www/essensplaner";
  };

  networking.firewall.allowedTCPPorts = [
    80 # nginx
    5000 # python backend
    8081 # tandoor
  ];

  services.tandoor-recipes = {
    enable = true;
    address = "0.0.0.0";
    port = 8081;
  };

  systemd.services.tandoor-recipes.serviceConfig = {
    TimeoutStartSec = 600;
  };
}
