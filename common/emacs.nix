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
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
    pandoc
    ripgrep
    shellcheck

    # formatting and other tools
    cargo
    rustc
    rustfmt

    # Typst support
    typst
    tree-sitter-grammars.tree-sitter-typst
  ];

  home.file = {
    ".config/doom/init.el".source = ../dotfiles/doom/init.el;
    ".config/doom/config.el".source = ../dotfiles/doom/config.el;
    ".config/doom/packages.el".source = ../dotfiles/doom/packages.el;
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
      FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
      TYPST_TREE_SITTER_LIB = "${pkgs.tree-sitter-grammars.tree-sitter-typst}";
  };
}
