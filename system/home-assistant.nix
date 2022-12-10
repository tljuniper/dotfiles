{ pkgs, ... }:

{
  virtualisation.oci-containers.containers.home-assistant = {
    volumes = [ "/home/juniper/home-assistant:/config" ];
    environment.TZ = "Europe/Berlin";
    image = "ghcr.io/home-assistant/home-assistant:stable";
    extraOptions = [
      "--network=host"
      "--device=/dev/ttyUSB0:/dev/ttyUSB0"
    ];
  };

  networking.firewall.interfaces."eth0".allowedTCPPorts = [
    8123 # Home assistant web UI
  ];
}
