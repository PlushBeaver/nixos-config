{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst # TODO: home-manager: services.dunst
    maim

    rxvt-unicode # TODO: weird behavior when reqired from i3.nix

    clipit
    xsel

    xorg.xev
    xorg.xprop
    xorg.xhost

    aspellDicts.ru
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science
  ];

  services.xserver = {
    enable = true;

    videoDrivers = ["nvidia"];

    layout = "us,ru";
    xkbModel = "pc105";
    xkbOptions = "grp:caps_toggle,grp_led:caps,grp_led:scroll,compose:ralt";

    startDbusSession = true;

    displayManager.sddm.enable = true;
    windowManager.i3.enable = true;
  };
}
