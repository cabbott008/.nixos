# ###### Special Config tNix.nix #######

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./thardware.nix
    ./tdisko.nix
    ../../base.nix
  ];

  networking.hostName = "tNix";

  networking = {
    networkmanager = {
      wifi.backend = lib.mkForce "wpa_supplicant";
    };
    wireless = {
      iwd = { # Trouble auto-connecting on tNix
        enable = lib.mkForce false;
      };
    };
  };
  
  services.displayManager = {
    enable = true; 
    defaultSession = "qtile";
    autoLogin = {
      enable = true;
      user = "ct";
    };
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

# DO NOT ALTER OR DELETE
  system.stateVersion = "24.05";
}
