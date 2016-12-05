{ config, pkgs, ... }:

{
  services.xserver = {
    windowManager.i3.enable = true;
    desktopManager.xfce.enable = true;
    #displayManager.gdm.enable = true;
  };
}
