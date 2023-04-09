{ pkgs, config, ... }:

let
  serverIP = "192.168.178.28";
  webPassword = "hunter2";
in
{
  virtualisation.oci-containers.containers.pihole = {
    image = "pihole/pihole:2023.03.1";
    ports = [
      "${serverIP}:53:53/tcp"
      "${serverIP}:53:53/udp"
      "3080:80"
      "30443:443"
    ];
    volumes = [
      "/var/lib/pihole/:/etc/pihole/"
      "/var/lib/dnsmasq.d:/etc/dnsmasq.d/"
    ];
    environment = {
      ServerIP = serverIP;
      TZ = "Europe/Berlin";
    };
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--dns=127.0.0.1"
      "--dns=1.1.1.1"
      "--hostname=${config.networking.hostName}"
      "-e WEBPASSWORD=${webPassword}"
    ];
    # workdir = "/var/lib/pihole/";
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/pihole 1777 root root"
    "d /var/lib/dnsmasq.d 1777 root root"
  ];

  networking.firewall.interfaces."eth0".allowedTCPPorts = [
    3080 # webui
    30443 # webui
  ];
}
