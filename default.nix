{ inputs, ... }:

{
  imports = [
    ./nixos
    ./hardware.nix
    ./system
    ./software
    (if inputs.secrets.work.enable then ./work else [])
  ];
}
