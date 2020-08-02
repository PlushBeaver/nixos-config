{ inputs, ... }:

{
  imports = [
    ./nixos
    ./hardware
    ./system
    ./software
    (if inputs.secrets.work.enable then ./work else [])
  ];
}
