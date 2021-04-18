{ inputs, pkgs, ... }:

{
  imports = [
    ./modules/docker.nix
  ];

  nix = {
    autoOptimiseStore = true;
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
    };
    trustedUsers = ["root" "@wheel"];
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.09";
}
