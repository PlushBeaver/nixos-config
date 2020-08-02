{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (qemu.override {
      hostCpuOnly = true;
      smbdSupport = true;
    })

    kvm
    qemu-utils
    OVMF
  ];
}
