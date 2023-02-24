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
          depends = "/mnt/ext4";
          device = "/mnt/ext4/var/lib/docker";
          options = [ "bind" ];
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

  environment.systemPackages = [pkgs.linuxPackages.nvidia_x11];

  hardware.pulseaudio.enable = true;
  hardware.opengl.extraPackages32 = [pkgs.pkgsi686Linux.libva];
  sound.enable = true;
}
