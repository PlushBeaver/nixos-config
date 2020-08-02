{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst # TODO: home-manager: services.dunst
    rofi  # TODO: home-manager: programs.rofi
    maim

    rxvt-unicode

    xxkb

    clipit
    xclip
    xsel
    xdotool

    xorg.xev
    xorg.xprop
    xorg.xhost

    hunspellDicts.ru-ru
    hunspellDicts.en-us
  ];
}
