{
  outputs = {self, nixpkgs }: {
    nixosConfigurations.amydesktopserver = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
