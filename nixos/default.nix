{ inputs, pkgs, ... }:

{
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
    registry = with inputs; {
      nixpkgs.flake = nixpkgs;
      nixpkgs-2111.flake = nixpkgs-2111;
      nixpkgs-2405.flake = nixpkgs-2405;
      home-manager.flake = home-manager;
      self.flake = self;
    };
    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "20.09";
}
