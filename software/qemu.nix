{ pkgs, ... }:

let
  qemuWithSamba = pkgs.qemu.override {
    hostCpuOnly = true;
    smbdSupport = true;
  };
in {
  virtualisation.libvirtd = {
    enable = true;
    qemuPackage = qemuWithSamba;
  };

  users.users."dmitry".extraGroups = [
    "libvirtd"
  ];

  environment.systemPackages = with pkgs; [
    OVMF
    kvm
    #(libguestfs.override { qemu = qemuWithSamba; }) -- broken in 20.09
    libosinfo
    libvirt
    qemu-utils
    qemuWithSamba
    virt-manager
    virt-viewer
  ];
}
