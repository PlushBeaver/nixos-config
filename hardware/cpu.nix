{ lib, ... }:

{
  boot.kernelModules = ["kvm-intel"];
  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
