{ inputs, self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system
    ./software
    (if inputs.secrets.work.enable then ./work else [])
  ];

  nix = {
    extraOptions = "experimental-features = nix-command flakes";
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      home-manager.flake = inputs.home-manager;
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
