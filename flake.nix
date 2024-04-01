{
  description = "My flaky system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    # vscode with current plugins works better with unstable
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    flake-compat.url = "github:edolstra/flake-compat";

    # For automatic disk formatting on system reinstall
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # For quality checks for this repo
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    # Up-to-date and large list of vscode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };

    # For relaying grafana alerts to Home Assistant
    ha-relay = {
      url = "github:pinpox/home-assistant-grafana-relay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
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
    , pre-commit-hooks
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
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              nixpkgs-fmt.enable = true;
              statix.enable = true;
              deadnix.enable = true;
              shellcheck.enable = true;
              # Hooks from pre-commit-hooks
              # See: https://github.com/cachix/pre-commit-hooks.nix/issues/31
              trailing-whitespace = {
                enable = true;
                name = "Trim Trailing Whitespace";
                entry = "${pkgs.python3Packages.pre-commit-hooks}/bin/trailing-whitespace-fixer";
                package = pkgs.python3Packages.pre-commit-hooks;
                types = [ "text" ];
              };
              end-of-file-fixer = {
                enable = true;
                name = "Fix End of Files";
                entry = "${pkgs.python3Packages.pre-commit-hooks}/bin/end-of-file-fixer";
                package = pkgs.python3Packages.pre-commit-hooks;
                types = [ "text" ];
              };
              check-executables-have-shebangs = {
                enable = true;
                name = "Check that executables have shebangs";
                description = "Ensures that (non-binary) executables have a shebang.";
                entry = "${pkgs.python3Packages.pre-commit-hooks}/bin/check-executables-have-shebangs";
                package = pkgs.python3Packages.pre-commit-hooks;
                types = [ "text" "executable" ];
              };
            };
          };
        };
        devShells.default = mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = [ nix-output-monitor nodePackages.cspell ] ++ self.checks.${system}.pre-commit-check.enabledPackages;
        };
      })
    //
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
              home-manager.users.juniper = _:
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
              home-manager.users.juniper = _:
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
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgsUnstableForSystem system;
          };
          pkgs = pkgsForSystem system;
          modules = [
            disko.nixosModules.disko
            ./hosts/swift/configuration.nix
            ./hosts/swift/disk-config.nix
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
                    ./home-manager/home.nix
                    ./home-manager/git-juniper.nix
                    ./home-manager/desktop.nix
                    ./home-manager/dconf-settings.nix
                    ./home-manager/vscode.nix
                    ./home-manager/xdg-user-dirs.nix
                    ./home-manager/backup-swift.nix
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
            ./hosts/carbon/configuration.nix
            ./hosts/carbon/disk-config.nix
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
                    ./home-manager/home.nix
                    ./home-manager/desktop.nix
                    ./home-manager/dconf-settings.nix
                    ./home-manager/run-rotation.nix
                    ./home-manager/vscode.nix
                    ./home-manager/xdg-user-dirs.nix
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
