{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (with inputs.nixpkgs-2111.legacyPackages.x86_64-linux;
      claws-mail-gtk2.override { enableSpellcheck = true; })

    ((emacsPackagesFor emacs).emacsWithPackages
      (epkgs: with epkgs.melpaPackages; [ elfeed ]))

    chromium
    (with inputs.nixpkgs-2411.legacyPackages.x86_64-linux;
      firefox)

    skypeforlinux
    tdesktop

    curl
    hping
    httpie
    iptables
    nmap
    qbittorrent
    socat
    wget
    wireshark-qt
  ];
}
