{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qemu_kvm
    qemu-utils
    (qemu.override { hostCpuOnly = true; })
    freerdp
    spice
  ];
}
