{
  description = "My flaky system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";

    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , home-manager
    , nixpkgs
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
          pkgs = pkgsForSystem system;
          modules = [
            ./hosts/rust/configuration.nix
            ./system/general.nix
            ./system/home-assistant.nix
            ./system/nextcloud.nix
            ./system/paperless-ngx.nix
            ./system/pihole.nix
            ./system/prometheus.nix
            ./system/rezepte-server.nix
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
          ];
        };
        pascal = lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = pkgsForSystem system;
          modules = [
            ./hosts/pascal/configuration.nix
            ./system/general.nix
            ./system/user-juniper.nix
            ./system/home-assistant.nix
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
                    ./home-manager/work.nix
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
