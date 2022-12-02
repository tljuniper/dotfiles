{ ... }:

{
  # Shell needs to be enabled here so user can set it as their default
  programs.zsh.enable = true;

  users.users.juniper = {
    isNormalUser = true;
    home = "/home/juniper";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = [
      ./authorized_keys
    ];
  }
}
