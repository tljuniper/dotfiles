_:

{
  services.prometheus.exporters = {
    node = {
      enable = true;
      openFirewall = true;
      enabledCollectors = [ "systemd" "processes" ];
      port = 9100;
    };
  };
}
