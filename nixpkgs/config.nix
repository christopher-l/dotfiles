{
  allowUnfree = true;

  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages

    workEnv = pkgs_.myEnvFun {
        name = "pyplot";
        buildInputs = [
          python35
          python35Packages.numpy
          python35Packages.matplotlib
        ];
    };

    all = with pkgs; buildEnv {  # pkgs is your overriden set of packages itself
      name = "all";
      paths = [
        dfeet
        kde5.dolphin
        ekiga
        firefox-bin
        gimp
        google-chrome
        hexchat
        htop
        inkscape
        keepassx2
        liferea
        mpv
        kde5.okular
        pandoc
        pdftk
        pidgin-with-plugins
        spotify
        termite
        thunderbird
        tig
        transmission_gtk
        vimHugeX
        vlc
        filezilla
        gnucash26
      ];
    };

    # nautilus = pkgs_.stdenv.lib.overrideDerivation pkgs_.gnome3.nautilus (oldAttrs: {
    #   buildInputs = [ gnome3.gvfs ];
    # });

    pidgin-with-plugins = pkgs_.pidgin-with-plugins.override {
      plugins = [ pkgs_.pidginotr pkgs_.pidgin-opensteamworks ];
    };

  };
}

  #packageOverrides = pkgs: rec {
    #neovim = pkgs.neovim.override {
    #  withPyGUI = true;
    #  vimAlias = true;
    #  configure = {
    #    customRC = "source $HOME/.config/nvim/init.vim";
    #    vam = {
    #      pluginDictionaries = [ "vimtex" ];
    #    };
    #  };
    #};

    #vim_configurable = pkgs.vim_configurable.customize {
    #  name = "vim";
    #  vimrcConfig = {
    #    #customRC = "source $HOME/.config/nvim/init.vim";
    #    #vam = {
    #    #  pluginDictionaries = [ ];
    #    #};
    #    gui = true;
    #  };
    #};

    #pidgin-with-plugins = pkgs.pidgin-with-plugins.override {
    #  plugins = [ pkgs.pidginotr pkgs.pidgin-opensteamworks ];
    #};

    #firefox-unwrapped = pkgs.firefox-unwrapped.override {
    #  enableGTK3 = true;
    #  enableOfficialBranding = true;
    #};
  #};

