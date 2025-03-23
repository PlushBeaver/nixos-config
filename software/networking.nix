{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ((emacsPackagesFor emacs).emacsWithPackages
      (epkgs: with epkgs.melpaPackages; [ elfeed ]))

    qbittorrent

    tdesktop

    wireshark-qt

    curl
    hping
    httpie
    iptables
    nmap
    socat
    wget
  ];
}
