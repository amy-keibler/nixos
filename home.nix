{ config, pkgs, ... }:

{
  imports = [];

  home.username = "amy";
  home.homeDirectory = "/home/amy";

  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}