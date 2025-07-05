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

    p7zip
    unrar
    unzip
    zip

    btrfs-progs
    ntfs3g
    ntfsprogs

    file
    inotify-tools
    tree
  ];
}
