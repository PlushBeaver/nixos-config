{ lib, pkgs, ... }:

{
  nix.settings.max-jobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  fileSystems =
    let
      btrfs = subvol: {
        device = "/dev/disk/by-uuid/621ae564-a03e-466b-8ba0-8d7830e8d8c8";
        fsType = "btrfs";
        options = ["noatime" "subvol=${subvol}"];
      };
    in {
        "/" = btrfs "@nixos";
        "/boot" = {
          device = "/dev/disk/by-uuid/4387-B2FA";
          fsType = "vfat";
        };
        "/home" = btrfs "@home";
        "/mnt/ext4" = {
          device = "/dev/disk/by-uuid/ac7a1122-1545-445d-97e5-32830c3f9c01";
          fsType = "ext4";
          options = [ "noatime" ];
        };
        "/var/lib/docker" = {
          depends = [ "/mnt/ext4" ];
          device = "/mnt/ext4/var/lib/docker";
          options = [ "bind" ];
        };
        "/mnt/storage" = {
          device = "/dev/disk/by-uuid/ddb45a85-2494-4de3-9515-26a75578e7d8";
          fsType = "btrfs";
          options = [ "rw" "noatime" "autodefrag" "compress-force=zstd" "nossd" "space_cache=v2" ];
        };
        "/tmp" = {
          device = "none";
          fsType = "tmpfs";
          options = [ "noatime" ];
        };
    };

  swapDevices = [
    { device = "/dev/disk/by-uuid/b57beab7-3bef-4a33-aa6d-093bf1e2af6a"; }
  ];

  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  console.keyMap = "ru";

  services.pipewire.enable = lib.mkForce false;
  services.pulseaudio.enable = true;
  services.pulseaudio.support32Bit = true;

  environment.systemPackages = [ pkgs.linuxPackages.nvidia_x11 ];
  hardware.nvidia.open = false;

  hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.libva ];
}
