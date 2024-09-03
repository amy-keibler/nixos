{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    emacs

    # Doom Emacs
    coreutils-prefixed
    fd
    ispell
    fontconfig
    gnugrep
    mdl
    nerdfonts
    pandoc
    ripgrep
    shellcheck

    # formatting and other tools
    cargo
    rustc
    rustfmt
  ];

  home.file = {
    ".config/doom/init.el".source = ../dotfiles/doom/init.el;
    ".config/doom/config.el".source = ../dotfiles/doom/config.el;
    ".config/doom/packages.el".source = ../dotfiles/doom/packages.el;
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables.FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
}
