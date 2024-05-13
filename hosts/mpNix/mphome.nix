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
      #     backupFileExtension = "backup";
    };

    git = {
      enable = true;
      userName = "cabbott008";
      userEmail = "curtisabbott@me.com";
    };
  };
}
