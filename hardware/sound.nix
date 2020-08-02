{ lib, pkgs, ...}:

{
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  environment.systemPackages = [pkgs.linuxPackages.nvidia_x11];

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = [pkgs.pkgsi686Linux.libva];
  sound.enable = true;
}
