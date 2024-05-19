{ config, lib, pkgs, modulesPath, ... }:

# let
#   # Define your.Xresources content
#   xresourcesContent = ''
#     Xft.dpi: 192
#   '';

#   # Create a.Xresources file in the Nix store
#   xresourcesFile = pkgs.writeText "Xresources" xresourcesContent;

#   # Ensure xorg.xrdb is available
#   xorgXRDB = pkgs.xorg.xrdb;
# in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
      };
    kernelModules = [
      "kvm-intel"
      "wl"
    ];
    extraModulePackages = [
      config.boot.kernelPackages.broadcom_sta
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = lib.mkDefault true;
    facetimehd.enable = true;
  };
  
  # Variables
  environment = {
    variables = {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5"; # Effects Obsidian & Vivaldi
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XCURSOR_SIZE = "96"; # Also added Xft.dpi: 192 to .Xresources in ~
    };
  };
  
  # Make the.Xresources file available in the user's home directory
  users.users.ca.home = "/home/ca";

  # # Add a script to.xinitrc to load.Xresources
  # systemd.services.load-xresources = {
  #   description = "Load.Xresources";
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.Type = "oneshot";
  #   script = ''
  #     ${xorgXRDB}/bin/xrdb -merge ${xresourcesFile}
  #   '';
  # };
    
  services.xserver = {
    dpi = 288;
    upscaleDefaultCursor = true;
  };

  services.mbpfan.enable = true;
  services.fstrim.enable = true;
}
