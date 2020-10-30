{ pkgs, ... }:

{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    (steam.override {
      extraPkgs = pkgs: [
        mono
        gtk3
        gtk3-x11
        libgdiplus
        zlib
      ];
      nativeOnly = true;
    }).run
  ];
}
