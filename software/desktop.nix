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

    aspellDicts.ru
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
  ];
}
