{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    geeqie
    libreoffice-fresh
    mpv
    pasystray
    pavucontrol
    qpdfview
    smplayer
    xarchiver

    # FIXME: aggressive file associations
    #calibre
  ];
}
