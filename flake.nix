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
      # system = "aarch64-linux";
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;

    in
    {
      homeManagerConfigurations = {
        juniper = home-manager.lib.homeManagerConfiguration {
          # pkgs = nixpkgs.legacyPackages.${system};
          inherit pkgs;
          modules = [
            ./home-manager/desktop.nix
            ./home-manager/git-juniper.nix
            ./home-manager/home.nix
            ./home-manager/vscode.nix
            {
              home = {
                username = "juniper";
                homeDirectory = "/home/juniper";
                stateVersion = "22.05";
              };
            }
          ];
        };
        agillert = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "agillert";
          homeDirectory = "/home/agillert";
          configuration = {
            imports = [
              ./home-manager/desktop.nix
              ./home-manager/git-agillert.nix
              ./home-manager/home.nix
              ./home-manager/vscode.nix
              ./home-manager/work.nix
            ];
          };
        };
      };

      nixosConfigurations = {
        rust = lib.nixosSystem rec {
          system = "aarch64-linux";
          modules = [
            ./hosts/rust/configuration.nix
            ./system/home-assistant.nix
            ./system/locales.nix
            ./system/pihole.nix
            ./system/rezepte-server.nix
            ./system/user-juniper.nix
          ];
        };
        pascal = lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/pascal/configuration.nix
            ./system/locales.nix
            ./system/user-juniper.nix
          ];
        };
        swift = lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/swift/configuration.nix
            ./system/desktop-base.nix
            ./system/locales.nix
            ./system/user-juniper.nix
          ];
        };
        blazer = lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/blazer/configuration.nix
            ./system/desktop-base.nix
            ./system/headset.nix
            ./system/locales.nix
            ./system/user-agillert.nix
          ];
        };
      };
    };
}
