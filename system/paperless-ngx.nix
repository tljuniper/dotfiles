{ pkgs, config, ... }:

let
  consumptionDir = "/var/lib/paperless-consume";
in
{
  # services.paperless = {
  #   enable = true;
  #   address = "0.0.0.0";
  #   port = 58080;
  #   inherit consumptionDir;
  #   consumptionDirIsPublic = true;
  #   extraConfig.PAPERLESS_OCR_LANGUAGE = "deu+eng";
  # };

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

  # Files are placed here by the scanner
  systemd.tmpfiles.rules = [
    "d ${consumptionDir} 0777 scanner users"
  ];

  # Debugging
  # services.openssh.logLevel = "DEBUG3";
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
}
