{ pkgs, config, ... }:

{
  services.grafana = {
    enable = true;
    settings.server = {
      http_port = 2342;
      http_addr = "0.0.0.0";
    };
  };

  services.prometheus = {
    enable = true;
    port = 9001;
    scrapeConfigs = [
      {
        job_name = "rust";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 9100 9001 2342 ];
}
