{
  description = "My flaky system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ha-relay.url = "github:pinpox/home-assistant-grafana-relay";
    ha-relay.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.flake-utils.follows = "flake-utils";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.inputs.nixpkgs-stable.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
    nix-vscode-extensions.inputs.flake-utils.follows = "flake-utils";

  };

  outputs =
    # use inputs@ so we have inputs.self, inputs.home-manager and inputs.nixpkgs accessible, too
    inputs@ { self
    , home-manager
    , nixpkgs
    , nixpkgs-unstable
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
                types = [ "text" ];
              };
              end-of-file-fixer = {
                enable = true;
                name = "Fix End of Files";
                entry = "${pkgs.python3Packages.pre-commit-hooks}/bin/end-of-file-fixer";
                types = [ "text" ];
              };
              check-executables-have-shebangs = {
                enable = true;
                name = "Check that executables have shebangs";
                description = "Ensures that (non-binary) executables have a shebang.";
                entry = "${pkgs.python3Packages.pre-commit-hooks}/bin/check-executables-have-shebangs";
                types = [ "text" "executable" ];
              };
            };
          };
        };
        devShells.default = mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = [ black statix deadnix shellcheck ];
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
            ./hosts/swift/configuration.nix
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
          specialArgs = {
            inherit inputs system;
            pkgs-unstable = pkgsUnstableForSystem system;
          };
          pkgs = pkgsForSystem system;
          modules = [
            ./hosts/blazer/configuration.nix
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
