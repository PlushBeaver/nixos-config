{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (claws-mail-gtk2.override {
      enableSpellcheck = true;
    })

    ((emacsPackagesGen emacs).emacsWithPackages (epkgs:
      with epkgs.melpaPackages; [
        elfeed
      ]))

    chromium
    firefox

    discord
    skype
    tdesktop

    curl
    hping
    httpie
    iptables
    ncat
    qbittorrent
    socat
    wget
    wireshark-qt
  ];
}
