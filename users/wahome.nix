{ config, pkgs, lib, home-manager, ... }:

{
  home = {
    stateVersion = "24.05";
    username = "wa";
    homeDirectory = lib.mkForce "/home/wa";

    sessionVariables = { };

    packages = [ ];

    file = {
    }; 
  };
  
  programs = {
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "Willgiam1";
      userEmail = "willabbott008@gmail.com";
    };
  };
}
