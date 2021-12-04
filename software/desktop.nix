{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rxvt-unicode

    flameshot

    xxkb

    clipit
    xclip

    xorg.xhost
    xorg.xkill

    aspellDicts.ru
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    teamviewer
  ];

  services.teamviewer.enable = true;

  services.xserver = {
    enable = true;

    videoDrivers = ["nvidia"];

    # FIXME: stopped working :(
    layout = "us,ru";
    xkbModel = "pc105";
    xkbOptions = "grp:caps_toggle,grp_led:caps,grp_led:scroll,compose:ralt";

    displayManager.sddm.enable = true;
    windowManager.i3.enable = true;
  };

  home-manager.users.dmitry.xsession = {
    enable = true;
    initExtra = ''
      xrdb -merge -override .Xresources
      setxkbmap -layout us,ru -option grp:caps_toggle,grp_led:caps,grp_led:scroll,compose:ralt -model pc105

      firefox &
      telegram-desktop &
      claws-mail &
      discord &
      '';
  };
}
