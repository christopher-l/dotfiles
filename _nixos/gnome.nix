{ config, pkgs, ... }:

{
  services.xserver = {
    desktopManager.gnome3.enable = true;
    displayManager.gdm.enable = true;
  };

  #security.pam.services.gdm.fprintAuth = true;
  #security.pam.services.polkit-1.fprintAuth = true;
  #security.pam.services.system-local-login.fprintAuth = true;
}
