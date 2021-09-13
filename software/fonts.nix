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
      (iosevka.override {
        privateBuildPlan = {
          family = "Iosevka";
          spacing = "term";
        };
        set = "term";
       })

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
