{
  description = "PlushBeaver's lodge blueprint";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    nixpkgs-2205.url = github:NixOS/nixpkgs/nixos-22.05;
    home-manager.url = github:nix-community/home-manager/release-21.11;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    secrets = {};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations.sovereign =
        let
          specialArgs = { inherit inputs; };

        in nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [./.] ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
          inherit specialArgs;
        };
    };
}
