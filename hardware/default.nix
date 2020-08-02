{ ... }:

{
  imports = [
    ./chipset.nix
    ./cpu.nix
    ./disk.nix
    ./input.nix
    ./graphics.nix
    ./sound.nix
  ];

  services.devmon.enable = true;
}
