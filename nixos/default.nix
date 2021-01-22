{ inputs, pkgs, ... }:

{
  imports = [
    ./modules/docker.nix
  ];

  nix = {
    autoOptimiseStore = true;
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
    trustedUsers = ["root" "@wheel"];
    gc = {
      automatic = true;
      options = "--delete-older-then 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.09";
}
