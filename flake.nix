{
  description = "My flaky system configuration";

    inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";

    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  }:
  let
    # system = "aarch64-linux";
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {
    homeManagerConfigurations = {
      juniper = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "juniper";
          homeDirectory = "/home/juniper";
          configuration = {
              imports = [
                  ./home-manager/home.nix
                  ./home-manager/git-juniper.nix
                  ./home-manager/vscode.nix
                  ./home-manager/desktop.nix
              ];
          };
       };
      agillert = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "agillert";
          homeDirectory = "/home/agillert";
          configuration = {
              imports = [
                  ./home-manager/home.nix
                  ./home-manager/git-agillert.nix
                  ./home-manager/vscode.nix
                  ./home-manager/desktop.nix
                  ./home-manager/window-manager.nix
                  ./home-manager/work.nix
              ];
          };
       };
    };

    nixosConfigurations = {
      raspi = lib.nixosSystem rec {
        system = "aarch64-linux";
        modules = [
          ./hosts/raspi/configuration.nix
          ./system/user-juniper.nix
          ./system/rezepte-server.nix
          ./system/pihole.nix
          ./system/home-assistant.nix
        ];
      };
    };
  };
}
