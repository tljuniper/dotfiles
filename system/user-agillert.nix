{ pkgs, ... }:

{
  # Shell needs to be enabled here so user can set it as their default
  programs.zsh.enable = true;

  users.users.agillert = {
    isNormalUser = true;
    home = "/home/agillert";
    createHome = true;
    group = "users";
    extraGroups = [ "wheel" "video" "audio" "disk" "networkmanager" ];
    shell = pkgs.zsh;
  };
}
