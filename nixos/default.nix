{ inputs, pkgs, ... }:

{
  imports = [ ./modules/docker.nix ];

  nix = {
    autoOptimiseStore = true;
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
    registry = with inputs; {
      nixpkgs.flake = nixpkgs;
      self.flake = self;
    };
    trustedUsers = [ "root" "@wheel" ];
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.09";
}
