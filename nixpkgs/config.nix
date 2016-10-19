{
  allowUnfree = true;

  packageOverrides = pkgs_: with pkgs_; {  # pkgs_ is the original set of packages

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
        #termite-git
        thunderbird
        tig
        transmission_gtk
        vimHugeX
        vlc
      ];
    };

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

