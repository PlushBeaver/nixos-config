{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kvm
    qemu-utils
    (qemu.override { hostCpuOnly = true; })
    freerdp
    spice
  ];
}
