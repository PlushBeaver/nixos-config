{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    geeqie
    imagemagick
    libreoffice-fresh
    mpv
    pasystray
    pavucontrol
    smplayer
    xarchiver

    # TODO: office.nix?
    ledger

    # FIXME: aggressive file associations
    calibre
  ];
}
