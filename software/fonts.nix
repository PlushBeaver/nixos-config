{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    fontconfig = {
      defaultFonts = with pkgs; {
        serif = [ "PT Serif" ];
        sansSerif = [ "PT Sans" ];
        monospace = [ "PT Mono" ];
      };
    };

    packages = with pkgs; [
      iosevka-bin
      noto-fonts-cjk-sans
      paratype-pt-mono
      paratype-pt-sans
      paratype-pt-serif
    ];
  };
}
