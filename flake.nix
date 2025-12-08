{
  description = "My flaky system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    # vscode with current plugins works better with unstable
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";

    # For automatic disk formatting on system reinstall
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # For quality checks for this repo
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    # Up-to-date and large list of vscode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # For relaying grafana alerts to Home Assistant
    ha-relay = {
      url = "github:tljuniper/home-assistant-grafana-relay/remove-image-url";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    nomnombring = {
      url = "github:tljuniper/nomnombring";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

  };

  outputs =
    # use inputs@ so we have inputs.self, inputs.home-manager and inputs.nixpkgs accessible, too
    inputs@ { self
    , home-manager
    , nixpkgs
    , nixpkgs-unstable
    , disko
    , ha-relay
    , flake-utils
    , git-hooks
    , nomnombring
    , ...
    }:
    let
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      pkgsUnstableForSystem = system: import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
      };

      inherit (nixpkgs) lib;

      juniper-home = {
        username = "juniper";
        homeDirectory = "/home/juniper";
      };

    in
    flake-utils.lib.eachDefaultSystem
      # We want to be able to have a devShell + pre-commit-checks for any system
      # Therefore we need to define a devShell for each of those systems
      (system:
      let pkgs = pkgsForSystem system;
      in
      with pkgs;
      {
        checks = {
          pre-commit-check = git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              check-executables-have-shebangs.enable = true;
              deadnix.enable = true;
              end-of-file-fixer.enable = true;
              nixpkgs-fmt = {
                enable = true;
                excludes = [ "dconf-settings\\.nix" ];
              };
              shellcheck.enable = true;
              statix.enable = true;
              trim-trailing-whitespace.enable = true;
            };
          };
        };
        devShells.default = mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = [ nix-output-monitor ] ++ self.checks.${system}.pre-commit-check.enabledPackages;
        };
      })
    //
    {
      nixosConfigurations = {
        rust = lib.nixosSystem rec {
          system = "aarch64-linux";
          pkgs = pkgsForSystem system;
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgsUnstableForSystem system;
          };
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./host/rust/configuration.nix
            ./system/adguard.nix
            ./system/general.nix
            ./system/home-assistant.nix
            ./system/nextcloud.nix
            ./system/prometheus-exporter.nix
            ./system/prometheus.nix
            ./system/scanner.nix
            ./system/user-juniper.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.juniper = _:
                {
                  imports = [
                    ./home
                  ];
                  home = juniper-home;
                };
            }
            nomnombring.nixosModules.nomnombring
            {
              tljuniper.services.nomnombring = {
                enable = true;
                configFile = "/var/nomnombring-config.ini";
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
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgsUnstableForSystem system;
          };
          pkgs = pkgsForSystem system;
          modules = [
            "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
            ./host/pascal/configuration.nix
            ./system/general.nix
            ./system/user-juniper.nix
            ./system/home-assistant.nix
            ./system/prometheus-exporter.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.juniper = _:
                {
                  imports = [
                    ./home
                  ];
                  home = juniper-home;
                };
            }
          ];
        };
        swift = lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgsUnstableForSystem system;
          };
          pkgs = pkgsForSystem system;
          modules = [
            disko.nixosModules.disko
            ./host/swift/configuration.nix
            ./host/swift/disk-config.nix
            ./system/desktop-base.nix
            ./system/general.nix
            ./system/user-juniper.nix
            ./system/trigger-backup-swift.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.juniper = _:
                {
                  imports = [
                    ./home
                    ./home/desktop
                    ./home/backup-swift.nix
                  ];
                  home = juniper-home;
                };
            }
          ];
        };
        matlab = lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgsUnstableForSystem system;
          };
          pkgs = pkgsForSystem system;
          modules = [
            disko.nixosModules.disko
            ./host/matlab/configuration.nix
            ./host/matlab/disk-config.nix
            ./system/desktop-base.nix
            ./system/general.nix
            ./system/user-juniper.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.juniper = _:
                {
                  imports = [
                    ./home
                  ];
                  home = juniper-home;
                };
            }
          ];
        };
        carbon = lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgsUnstableForSystem system;
          };
          pkgs = pkgsForSystem system;
          modules = [
            disko.nixosModules.disko
            ./host/carbon/configuration.nix
            ./host/carbon/disk-config.nix
            ./system/desktop-base.nix
            ./system/headset.nix
            ./system/general.nix
            ./system/user-agillert.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.agillert = _:
                {
                  imports = [
                    ./home
                    ./home/desktop
                    ./home/run-rotation.nix
                    ./home/timetracking.nix
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
