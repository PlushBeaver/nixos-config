{ lib, pkgs, ... }:

{
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  environment.systemPackages = [pkgs.linuxPackages.nvidia_x11];
}
