{ config, pkgs, ... }:

rec {
  imports = [
    ./common/emacs.nix
  ];

  home.username = "amy";
  home.homeDirectory = "/home/amy";

  home.packages = with pkgs; [
    
  ];

  programs.bash = {
    enable = true;

    enableCompletion = true;

    historySize = 1000;
    historyFileSize = 2000;
    historyControl = [ "ignoredups" "ignorespace" ];

    sessionVariables = {
      PATH = "$PATH:${home.homeDirectory}/.config/emacs/bin";
    };
  };

  programs.direnv.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      kubernetes = {
        disabled = true;
      };
    };
  };

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
