{ config, pkgs, ... }:

{
  # Network
  networking.wireless.enable = true;
  networking.wireless.interfaces = [ "wlp3s0" ];
  networking.wireless.userControlled.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    termite
    xorg.xbacklight xorg.xkill dmenu2 i3status pavucontrol wpa_supplicant_gui scrot
    i3lock xss-lock
    gnome3.gnome_themes_standard gnome3.adwaita-icon-theme gnome3.dconf
  ];

  # X11 windowing system
  services.xserver = {
    windowManager.i3.enable = true;
    windowManager.default = "i3"; # does not work?
    #desktopManager.kde5.enable = true;
    desktopManager.default = "none"; # does not work?
    displayManager.sessionCommands = ''
      # Keyboard repeat rate
      xset r rate 250 30
      # Fix Qt 5 themes an icons not being applied
      export KDE_FULL_SESSION=true
      export KDE_SESSION_VERSION="5"
      # Needed for cursor theme to be found
      export XCURSOR_PATH=/run/current-system/sw/share/icons:
      # Disable screen saver (dpms will still switch off the display)
      xset s off
    '';
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };

  environment.shellInit = ''
    #export GTK_PATH=/run/current-system/sw/lib/gtk-2.0
    export GTK2_RC_FILES=/run/current-system/sw/share/themes/Adwaita/gtk-2.0/gtkrc:$HOME/.gtkrc-2.0
  '';

  # services.gnome3.gnome-keyring.enable = true;

  # Security
  security.pam.services.slim.fprintAuth = true;
  systemd.targets.hibernate.wants = [ "i3lock@chris.service" ];

  # Gnome
  services.xserver.desktopManager.gnome3.enable = true;
  networking.networkmanager.enable = false;

}
