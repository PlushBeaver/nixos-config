{
  description = "PlushBeaver's lodge blueprint";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-2111.url = "github:NixOS/nixpkgs/nixos-21.11";
    nixpkgs-2405.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-2411.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    secrets = { };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.sovereign = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./. ] ++ [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
