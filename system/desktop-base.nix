{ pkgs, ... }:
{
  services = {
    # Install gnome
    desktopManager = {
      gnome.enable = true;
    };
    displayManager = {
      gdm.enable = true;
    };

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
    };
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  xdg.autostart.enable = true;

  # Exclude gnome applications
  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
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
  ];

  # Enable the function keys for Keychron keyboard
  # https://mikeshade.com/posts/keychron-linux-function-keys/
  environment.etc."modprobe.d/hid_apple.conf".text =
    ''
      options hid_apple fnmode=0
    '';

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];
    # Function keys for Keychron keyboard
    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';
  };
}
