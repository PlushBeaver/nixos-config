{
  description = "PlushBeaver's lodge blueprint";

  inputs = {
    nixpkgs = {
      url = github:NixOS/nixpkgs/nixos-20.03;
    };

    home-manager = {
      type = "github";
      owner = "rycee";
      repo = "home-manager";
      ref = "bqv-flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets = {};
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      versionInfo = { system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev; };
    in {
      nixosConfigurations.sovereign = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./.] ++ [versionInfo];
        specialArgs = { inherit inputs; };
      };
    };
}
