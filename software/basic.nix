{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jq

    htop
    iotop
    ncdu

    dnsutils
    ethtool
    pciutils
    tcpdump
    traceroute
    usbutils

    unzip
    unrar
    zip

    btrfs-progs
    ntfs3g
    ntfsprogs
    smartmontools

    file
    inotify-tools
    tree
  ];
}
