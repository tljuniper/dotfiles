{ pkgs, ... }:

{
  virtualisation.oci-containers.containers.home-assistant = {
    volumes = [ "/home/juniper/home-assistant:/config" ];
    environment.TZ = "Europe/Berlin";
    image = "ghcr.io/home-assistant/home-assistant:2022.12";
    extraOptions = [
      "--network=host"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    8123 # Home assistant web UI
  ];

  environment.systemPackages = with pkgs; [
    sqlite-interactive
  ];

}
