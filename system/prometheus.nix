{ config, pkgs-unstable, ... }:

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
    package = pkgs-unstable.prometheus;
    scrapeConfigs = [
      {
        job_name = "rust";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
      {
        job_name = "rust-ha";
        scrape_interval = "1m";
        metrics_path = "/api/prometheus";
        static_configs = [{
          targets = [ "127.0.0.1:8123" ];
        }];
      }
      {
        job_name = "pascal";
        scrape_interval = "2m";
        scrape_timeout = "1m";
        static_configs = [{
          targets = [ "pascal:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
    ];
  };

  networking.firewall.allowedTCPPorts = [ 9100 9001 2342 ];
}
