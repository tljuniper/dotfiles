_:

{
  imports = [
    ./shell
  ];

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "22.05";
}
