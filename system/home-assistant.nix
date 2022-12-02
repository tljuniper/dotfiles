{ pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    openFirewall = true;
    extraComponents = [
      "met"
      "edl21"
      "esphome"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
  };

}
