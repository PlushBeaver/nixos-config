{ pkgs, ... }:

{
  fonts = let def = "Iosevka Light";
  in {
    enableDefaultFonts = true;

    fontconfig = {
      defaultFonts = {
        serif = [ def ];
        sansSerif = [ def ];
        monospace = [ def ];
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

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      paratype-pt-mono
      paratype-pt-sans
      paratype-pt-serif
    ];
  };
}
