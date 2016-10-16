{ config, pkgs, ... }:

{
  #systemd.services.snapshot = {
  #  description = "Custom Snapshot Script";
  #  serviceConfig = {
  #    Type = "oneshot";
  #    Environment = "PATH=/run/current-system/sw/bin/";
  #    ExecStart = "/root/bin/snapshot.sh";
  #  };
  #};
  #systemd.timers.snapshot = {
  #  description = "Daily Snapshot";
  #  wantedBy = [ "timers.target" ];
  #  timerConfig = {
  #    OnCalendar = "daily";
  #    Persistent = "true";
  #  };
  #};
  systemd.services."i3lock@" = {
    description = "Automatic Screen Lock";
    before = [ "hibernate.target" ];
    environment = {
      DISPLAY = ":0";
    };
    serviceConfig = {
      Type = "simple";
      User = "%I";
      ExecStart = "/run/current-system/sw/bin/i3lock -i /home/%I/.i3/lockbg.png -n";
    };
  };
}
