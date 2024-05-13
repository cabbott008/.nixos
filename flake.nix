{
  description = "Curtis's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
        ./modules/home-manager/default.nix; # Arbitrary name pointing to default.nix
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
              ]; # Arbitrary name bringing in the above declared import
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
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
              home-manager.sharedModules = [ self.homeManagerModules.default ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
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
              home-manager.sharedModules = [ self.homeManagerModules.default ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
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
