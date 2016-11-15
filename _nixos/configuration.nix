# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./units.nix
      /etc/nixos/vpnc.nix

      ./i3.nix
    ];

  #nix.useChroot = true;

  # GRUB
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.timeout = 1;
  # boot.loader.grub.extraConfig = "terminal_output console";


  # File Systems
  fileSystems."/" =
    { device = "/dev/sda3";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };

  swapDevices = [ { device = "/dev/sda2"; } ];


  # Hardware
  boot.kernelModules = [ "tp_smapi" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.tp_smapi ];
  boot.extraModprobeConfig = ''
    options iwlwifi led_mode=1
  '';

  services.tlp = {
    enable = true;
    extraConfig = ''
      DEVICES_TO_DISABLE_ON_STARTUP="bluetooth"
      DISK_DEVICES="sdb"
      DISK_SPINDOWN_TIMEOUT_ON_AC="24"
      DISK_SPINDOWN_TIMEOUT_ON_BAT="12"
      START_CHARGE_THRESH_BAT0=70
      STOP_CHARGE_THRESH_BAT0=80 
    '';
  };

  nixpkgs.config = {
    packageOverrides = pkgs: {
      bluez = pkgs.bluez5;
    };
  };

  hardware = {
    trackpoint.emulateWheel = true;
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.support32Bit = true;
    bluetooth.enable = true;
  };

  nixpkgs.config.pulseaudio = true;

  # Network
  networking.hostName = "kestrel";
  networking.dhcpcd.extraConfig = ''
    noarp
  '';
  # networking.firewall.enable = false;


  # General
  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  services.journald.extraConfig = ''
    SystemMaxUse=50M
  '';

  systemd.extraConfig = ''
    DefaultTimeoutStopSec = 10
  '';

  # Packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Basic
    psmisc wget git tmux bc vim man-pages

    # Monitor
    htop iftop

    # Hardware
    hdparm

    # System
    gnupg pinentry
    #nix-zsh-completions

    # Utils
    file
    dpkg unrar
    gnome3.dconf-editor xorg.xev
    pciutils
    wavemon nmap socat mtr
    androidsdk android-udev-rules

    # Dev
    gnumake
    #(lib.overrideDerivation gcc (attrs: {
    #  enableMultilib = true;
    #}))
    gcc_multi
    gdb
    gfortran
    (haskellPackages.ghcWithPackages (self : [
      self.QuickCheck
    ]))
    texlive.combined.scheme-full
    python2
    (pkgs.python35.buildEnv.override {
      extraLibs = with pkgs.python35Packages; [
        numpy
        matplotlib
        pyqt5
        #(matplotlib.override { enableGtk3 = true; })
      ];
    })
    octaveFull

    # Misc
    xsel # provides clipboard support for nvim
    libinput
  ];


  # Fonts
  fonts = {
    fontconfig = {
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif = [ "Source Serif Pro" ];
      };
      ultimate = {
        allowBitmaps = false;
      };
    };
    # enableFontDir = true;
    # enableGhostscriptFonts = true;
    # fontconfig.hinting.autohint = false;
    fonts = with pkgs; [
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
  };


  # X11 windowing system
  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "altgr-intl";
    # xkbOptions = "eurosign:e";

    libinput = {
      enable = true;
      tapping = false;
      naturalScrolling = true;
    #  tapButtons = false;
    #  twoFingerScroll = true;
    #  accelFactor = "0.015";
    #  palmDetect = true;
    #  additionalOptions = ''
    #    Option "PalmMinWidth" "5"
    #  '';
    };

    desktopManager.xterm.enable = false;
  };

  environment.shellInit = ''
    export EDITOR=vim
    export MOZ_USE_XINPUT2=1
  '';


  # Services
  # services.redshift = {
  #   enable = true;
  #   latitude = "51";
  #   longitude = "11.3";
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.printing = {
    enable = true;
    # drivers = [ pkgs.gutenprint ];
  };

  # services.xserver.startGnuPGAgent = true;
  programs.ssh.startAgent = false;

  # services.avahi.enable = true;

  virtualisation.virtualbox.host.enable = true;
  # nixpkgs.config.virtualbox.enableExtensionPack = true;

  # Security
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = true;

  security.polkit.extraConfig = ''
    /* Log authorization checks. */ 
    polkit.addRule(function(action, subject) { 
        polkit.log("user " + subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
    });
    /* Allow users in wheel group to mount filesystems without authentication */
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.udisks2.filesystem-mount-system" &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
    /* Allow users in wheel group to power off the system, reboot, etc. without authentication */
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.policy" &&
            subject.isInGroup("wheel")) {
            return polkit.Result.YES;
        }
    });
  '';



  # Shell
  programs.zsh.enable = true;
  # users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  environment.etc."zshrc.local".text = ''
    # load grml config
    . ${pkgs.grml-zsh-config}/etc/zsh/zshrc
    . ${pkgs.grml-zsh-config}/etc/zsh/keephack
    # new-tab for the termite terminal emulator
    if [[ $TERM == xterm-termite ]]; then
      . ${pkgs.gnome3.vte-select-text}/etc/profile.d/vte.sh
      __vte_osc7
    fi
    # tab completion for man pages
    export MANPATH=$HOME/.nix-profile/share/man:/run/current-system/sw/share/man
    # fix XDG_DATA_DIRS being set to a lot of directories by some GUI applications
    export XDG_DATA_DIRS="$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share:/run/current-system/sw/share"
  '';
  programs.bash.enableCompletion = true;


  # Users
  users.extraUsers.chris = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/chris";
    shell = "/run/current-system/sw/bin/zsh";
    extraGroups = [ "wheel" "vboxusers" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

}
