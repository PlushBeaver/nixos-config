{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    OVMF
    kvm
    qemu-utils
    (qemu.override { hostCpuOnly = true; })
    freerdp
    spice
  ];
}
