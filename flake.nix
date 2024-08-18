{
  description = "Curtis's NixOS Installation Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/e90d868245388a377314a1684e6795fb80aeae34";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nvim-flake = {
      url = "github:cabbott008/nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    with inputs; {
      homeManagerModules.default = import
        ./modules/home-manager/default.nix;
      homeManagerModules.HiDPI = import
        ./modules/home-manager/DPI-Hi.nix;
      homeManagerModules.NormDPI = import
        ./modules/home-manager/DPI-Low.nix;
      nixosConfigurations = {

        mpNix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/mpNix/mpNix.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                self.homeManagerModules.default
                self.homeManagerModules.HiDPI
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
            }
          ];
        };

        iNix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/iNix/iNix.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                self.homeManagerModules.default
                self.homeManagerModules.NormDPI
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
            }
          ];
        };

        tNix = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/tNix/tNix.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                self.homeManagerModules.default
                self.homeManagerModules.NormDPI
              ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
            }
          ];
        };

        xiso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/xiso/xiso.nix ];
        };
      };
    };
}
