{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    esphome
    esptool
    python3Packages.tornado
  ];
}
