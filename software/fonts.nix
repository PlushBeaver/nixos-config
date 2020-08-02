{ pkgs, ... }:

{
  fonts = {
    enableDefaultFonts = true;

    fontconfig = {
      defaultFonts = {
        serif = ["PT Serif"];
        sansSerif = ["PT Sans"];
        monospace = ["PT Mono"];
      };
    };

    fonts = with pkgs; [
      iosevka

      liberation_ttf

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      paratype-pt-mono
      paratype-pt-sans
      paratype-pt-serif
    ];
  };
}
