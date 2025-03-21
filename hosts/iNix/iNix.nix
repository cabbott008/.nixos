####### Special Config iNix.nix #######

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./ihardware.nix
    ../../modules/nixos/nvidia-mac.nix
      ./idisko.nix  
    ../../base.nix
  ];
  
  networking.hostName = "iNix";

  services = {
    logind = {
      powerKey = lib.mkForce "suspend";
    };
    displayManager = {
      enable = true; 
      defaultSession = "qtile";
      autoLogin = {
        enable = true;
        user = "wa";
      };
    };
  };
  
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/ca/.steam/root/compatibilitytools.d";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ca".imports = [
          ../../users/cahome.nix
        ];
      "ct".imports = [
          ../../users/cthome.nix
        ];
      "wa".imports = [
        ../../users/wahome.nix
      ];
    };
  };
  
# Define additional user accounts. 
  users.users.ct = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ]; 
  };
  
  users.users.wa = {
    isNormalUser = true;
    extraGroups = [ "sudo" "networkmanager" "wheel" "libvirtd" "kvm"];
  };

  environment.systemPackages = with pkgs; [
    obs-studio
    darktable
    mangohud
    protonup
    lutris
    heroic
  ];

# DO NOT ALTER OR DELETE
  system.stateVersion = "24.05";
}
