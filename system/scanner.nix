{ pkgs, config, options, ... }:

let
  scannerDir = "/var/lib/scanned-files";
in
{
  networking.firewall.allowedTCPPorts = [ 58080 ];

  users.users.scanner = {
    # Must be a normal user, otherwise the scanner will fail to establish a connection
    isNormalUser = true;
    createHome = true;
    home = "/var/lib/scanner";
    group = "users";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCz2DQM0IpWbKYP5gpltYNx3yzL7WgLIM9tPkBt7I/G78ciIyCr13E+Ug7TgkMlYLGDyNOLLSLMhq5QZBl11EZbKBhSvEwHVauUn08Di6BeQAINW+/HPHdQpa33CIvqqyGXFbJCTuH43d6w0H3o1YW0y+7g2zK5Z633ofYeiaaaIWCS4zh2hcQit05ux1Ed3SVMQmDOeJgPCyuTzrfCDJqLJD1I6Y6s300sV61saWL2zCo7cMCBzLMJy53lGExYLbhhdFai2bf9VOpsgXufr04DB9bXUeqSPPsCBWMyr3vDLeHVGPRyMZCJsEgj+ZXSOtdD8IxPYwRDKL6TbF0TfNzL root@BRN000EC691FF0E"
    ];
  };

  systemd.tmpfiles.rules = [
    # Files are placed here by the scanner
    "d ${scannerDir} 0777 scanner users"
  ];

  # Debugging
  # services.openssh.settings.LogLevel = "DEBUG3";
  # services.openssh.sftpFlags = [
  #   "-l DEBUG3"
  #   "-e"
  # ];

  # Drucker sind der natürliche Feind des Menschen.
  # Add ssh-rsa to accepted algorithms, it's the only one supported by the
  # scanner.
  # Needs to happen here (=sshd_config) rather than in ssh_config. The ssh
  # config only lists which algorithms are available, not which ones are
  # *allowed* by the server.
  services.openssh.extraConfig = ''
    HostKeyAlgorithms +ssh-rsa
    PubkeyAcceptedAlgorithms +ssh-rsa
  '';

  # Now, we need to add another MAC as well because the scanner only supports
  # antediluvian ones.
  # We can't add it to extraConfig like `HostKeyAlgorithms` above because there
  # is already a Macs line in sshd_conf and with recent versions of OpenSSH it's
  # "first match wins".
  # See: https://nixos.org/manual/nixos/stable/release-notes.html#sec-release-22.11-incompatibilities
  # But: We have a separate setting for setting the MACs, great! So we can just
  # add the antediluvian stuff there, right?
  # Well, almost. We need to add it to the existing list, after all.
  # So... how do we get that default setting?
  # Turns out, we need to do some really fucked up introspection stuff to get to
  # the submodule they're in. Luckily, other people also use seem to use
  # scanners.
  # https://discourse.nixos.org/t/extend-default-value-for-services-openssh-settings-macs-in-23-05/28673/2
  # There goes another hour of my life that I'll never get back...
  services.openssh.settings.Macs = (options.services.openssh.settings.type.getSubOptions [ ]).Macs.default ++ [ "hmac-sha2-512" ];

  # Additional config in scanner:
  # Add public key on server machine to scanner config via scanner Web UI
  # /etc/ssh/ssh_host_rsa_key.pub
}
