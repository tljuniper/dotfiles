{ pkgs, config, ... }:

{
  # Manual configuration required for setting up user login
  # - Create Bcrypt password hash with htpasswd -B
  # - Shutdown adguardhome.service
  # - Enter that password in /var/lib/AdGuardHome/AdGuardHome.yaml
  # users:
  #   - name: <username>
  #   - password: <hash-part-of-password-after-colon>
  # - Start adguardhome.service
  # Further configuration (e.g. use custom DNS server) in web interface
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    # Debugging
    # extraArgs = [ "--verbose" ];
    settings.bind_port = 3000;
  };

  networking.firewall.interfaces."end0".allowedUDPPorts = [ 53 ];
}
