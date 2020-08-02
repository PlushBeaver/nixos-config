{ ... }:

{
  boot.initrd.kernelModules = [
    "btrfs"
    "dm-snapshot"
  ];

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
}
