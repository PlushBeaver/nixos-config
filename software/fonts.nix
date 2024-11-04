{ pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;

    fontconfig = {
      defaultFonts = with pkgs; {
        serif = [ "PT Serif" ];
        sansSerif = [ "PT Sans" ];
        monospace = [ "PT Mono" ];
      };
    };

    fonts = with pkgs; [
      iosevka-bin
      noto-fonts-cjk
      paratype-pt-mono
      paratype-pt-sans
      paratype-pt-serif
    ];
  };
}
