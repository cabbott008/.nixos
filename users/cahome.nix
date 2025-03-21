{ config, pkgs, lib, home-manager, ... }:

{
  home = {
    stateVersion = "24.05";
    username = "ca";
    homeDirectory = lib.mkForce "/home/ca";

    sessionVariables = { };

    packages = [ ];

    file = { };
  };

  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Nubca";
      userEmail = "inspiredplans@gmail.com";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
