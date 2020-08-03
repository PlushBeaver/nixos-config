{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (claws-mail.override {
      enableSpellcheck = true;
    })

    chromium
    firefox
    pan

    discord
    tdesktop
    zoom-us

    hping
    httpie
    iptables
    ncat
    qbittorrent
    socat
    wireshark-qt

    (makeAutostartItem {
      name = "org.qbittorrent.qBittorrent";
      package = qbittorrent;
    })

    (makeAutostartItem {
      name = "pan";
      package = pan;
    })
  ];
}
