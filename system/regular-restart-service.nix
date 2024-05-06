{ pkgs, ... }:
{
  # Systemd service that gets restarted by another service at a defined time
  systemd = {
    services.meta-test-service = {
      description = "Meta test service";
      path = [ pkgs.bash ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = pkgs.writeScript "test.sh" ''
          #!/usr/bin/env bash
          set -euo pipefail

          while true
          do
            echo "Meta test service is running..."
            sleep 5
          done
        '';
        Restart = "always";
        RestartSec = 3;
      };
      serviceConfig = { };

    };

    services.test-service = {
      description = "Run test service";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/systemctl try-restart meta-test-service.service";
      };
    };
    timers.test-service = {
      description = "Restart timer for the test service";
      partOf = [ "test-service.service" ];
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* *:*:00";
        Persistent = false;
        Unit = "test-service.service";
      };
    };
  };
}
