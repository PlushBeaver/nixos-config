{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
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

    minecraft
  ];
}
