# ###### Special Config mpNix.nix #######

{ config, inputs, lib, pkgs, modulesPath, home-manager, ... }:

{
  imports = [
    ./mphardware.nix
    inputs.disko.nixosModules.default
    (import ./mpdisko.nix { device = "/dev/sda"; })
    ../../base.nix
  ];

  networking.hostName = "mpNix";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "ca" = import ../../users/cahome.nix; };
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "ca";
  };

  hardware.keyboard.qmk.enable = true;
  
  environment.systemPackages = [
    pkgs.qmk-udev-rules
  ];
}
