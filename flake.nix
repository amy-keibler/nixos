{
  inputs  = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.amydesktopserver = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./amydesktopserver/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.amy = import ./home.nix;
        }
      ];
    };

    nixosConfigurations.amylaptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./amylaptop/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.amy = import ./home.nix;
        }
      ];
    };
  };
}
