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
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.09";
}
