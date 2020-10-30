{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    geeqie
    imagemagick
    #libreoffice-fresh -- not in cache, too slow to build
    mpv
    pasystray
    pavucontrol
    qpdfview
    smplayer
    xarchiver

    # TODO: office.nix?
    ledger

    # FIXME: aggressive file associations
    #calibre
  ];
}
