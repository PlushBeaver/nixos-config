{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (claws-mail.override {
      enableSpellcheck = true;
    })

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
