{ lib, pkgs, ... }:

{
  nix.maxJobs = lib.mkDefault 8;
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
      esp = {
        device = "/dev/disk/by-uuid/4387-B2FA";
        fsType = "vfat";
      };
      tmpfs = {
        device = "none";
        fsType = "tmpfs";
        options = ["noatime"];
      };
      in {
        "/" = btrfs "@nixos";
        "/boot" = esp;
        "/home" = btrfs "@home";
        "/var/lib/docker" = btrfs "@docker";
        "/tmp" = tmpfs;
    };

  swapDevices = [
    { device = "/dev/disk/by-uuid/b57beab7-3bef-4a33-aa6d-093bf1e2af6a"; }
  ];

  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  console.keyMap = "ru";

  environment.systemPackages = [pkgs.linuxPackages.nvidia_x11];

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = [pkgs.pkgsi686Linux.libva];
  sound.enable = true;
}