{ inputs, pkgs, ... }:

let
  unstable = inputs.unstable.legacyPackages.x86_64-linux;
in {
  environment.systemPackages = with pkgs; [
    (claws-mail.override {
      enableSpellcheck = true;
    })

    chromium
    firefox

    discord
    quassel
    skype
    unstable.tdesktop

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
