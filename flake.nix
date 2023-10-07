{
  description = "My flaky system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ha-relay.url = "github:pinpox/home-assistant-grafana-relay";
    ha-relay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    # use inputs@ so we have inputs.self, inputs.home-manager and inputs.nixpkgs accessible, too
    inputs@ { self
    , home-manager
    , nixpkgs
    , ha-relay
    , ...
    }:
    let
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;

      juniper-home = {
        username = "juniper";
        homeDirectory = "/home/juniper";
      };

    in
    {
      nixosConfigurations = {
        rust = lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          pkgs = pkgsForSystem system;
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./hosts/rust/configuration.nix
            ./system/adguard.nix
            ./system/general.nix
            ./system/home-assistant.nix
            ./system/nextcloud.nix
            ./system/prometheus-exporter.nix
            ./system/prometheus.nix
            ./system/rezepte-server.nix
            ./system/scanner.nix
            ./system/user-juniper.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.juniper = { config, lib, pkgs, ... }:
                {
                  imports = [
                    ./home-manager/home.nix
                    ./home-manager/git-juniper.nix
                  ];
                  home = juniper-home;
                };
            }
            ha-relay.nixosModules.ha-relay
            {
              pinpox.services.home-assistant-grafana-relay = {
                enable = true;
                # Manually add grafana webhook for URL: http://localhost:12000
                listenHost = "localhost";
                listenPort = "12000";
                haUri = "http://localhost:8123/api/services/notify/notify";
                # File with ha-relay user permissions and content:
                # AUTH_TOKEN="LONG_LIVED_HOME_ASSISTANT_ACCESS_TOKEN"
                envFile = "/var/grafana-ha-relay-long-lived-token";
              };
            }
          ];
        };
        pascal = lib.nixosSystem rec {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          pkgs = pkgsForSystem system;
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./hosts/pascal/configuration.nix
            ./system/general.nix
            ./system/user-juniper.nix
            ./system/home-assistant.nix
            ./system/prometheus-exporter.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.juniper = { config, lib, pkgs, ... }:
                {
                  imports = [
                    ./home-manager/home.nix
                    ./home-manager/git-juniper.nix
                  ];
                  home = juniper-home;
                };
            }
          ];
        };
        swift = lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          pkgs = pkgsForSystem system;
          modules = [
            ./hosts/swift/configuration.nix
            ./system/desktop-base.nix
            ./system/general.nix
            ./system/user-juniper.nix
            ./system/trigger-backup-swift.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.juniper = { config, lib, pkgs, ... }:
                {
                  imports = [
                    ./home-manager/home.nix
                    ./home-manager/git-juniper.nix
                    ./home-manager/desktop.nix
                    ./home-manager/vscode.nix
                    ./home-manager/xdg-user-dirs.nix
                    ./home-manager/backup-swift.nix
                  ];
                  home = juniper-home;
                };
            }
          ];
        };
        blazer = lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          pkgs = pkgsForSystem system;
          modules = [
            ./hosts/blazer/configuration.nix
            ./system/desktop-base.nix
            ./system/headset.nix
            ./system/general.nix
            ./system/user-agillert.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.agillert = { config, lib, pkgs, ... }:
                {
                  imports = [
                    ./home-manager/home.nix
                    ./home-manager/git-agillert.nix
                    ./home-manager/desktop.nix
                    ./home-manager/vscode.nix
                  ];
                  home = {
                    username = "agillert";
                    homeDirectory = "/home/agillert";
                  };
                };
            }
          ];
        };
      };
    };
}
