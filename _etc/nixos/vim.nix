with import <nixpkgs> {};

pkgs.vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = ''
    set nu
    set ts=4
    set sw=4
    set et
    set autoindent
    if filereadable($HOME . "/.vimrc")
      source $HOME/.vimrc
    endif
  '';
  vimrcConfig.vam.pluginDictionaries = [
  ];
}
