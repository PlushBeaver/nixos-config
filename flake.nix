{
  description = "PlushBeaver's lodge blueprint";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
    unstable.url = github:NixOS/nixpkgs/nixos-unstable;

    home = {
      url = github:nix-community/home-manager/release-20.09;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {};
  };

  outputs = { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.sovereign =
        let
          specialArgs = { inherit inputs; };

          hm-nixos-as-super = { config, lib, ... }: {
            options.home-manager.users = lib.mkOption {
              type = lib.types.attrsOf (lib.types.submoduleWith {
                modules = [ ];
                specialArgs = specialArgs // {
                  super = config;
                };
              });
            };
          };

        in nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [./.] ++ [
            inputs.home.nixosModules.home-manager
            hm-nixos-as-super
          ];
          inherit specialArgs;
        };
    };
}
