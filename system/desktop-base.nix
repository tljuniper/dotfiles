{ config, lib, pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Install gnome
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  xdg.autostart.enable = true;

  # Exclude gnome applications
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    gnome-music
    gnome-terminal
    epiphany # web browser
    geary # email reader
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Enable the function keys for Keychron keyboard
  # https://mikeshade.com/posts/keychron-linux-function-keys/
  environment.etc."modprobe.d/hid_apple.conf".text =
    ''
      options hid_apple fnmode=0
    '';

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';
}
