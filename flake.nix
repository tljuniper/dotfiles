{
  description = "My flaky system configuration";

    inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  }:
  let
    system = "aarch64-linux";

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
                  ./home-manager/vim.nix
                  ./home-manager/git.nix
                  ./home-manager/zsh.nix
              ];
          };
       };
    };

    nixosConfigurations = {
      raspi = lib.nixosSystem rec {
        inherit system;
        modules = [
          ./hosts/raspi/configuration.nix
        ];
      };
    };
  };
}
