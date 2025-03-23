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

    otpclient
  ];

  services.xserver = {
    enable = true;

    videoDrivers = ["nvidia"];

    # FIXME: stopped working :(
    xkb.layout = "us,ru";
    xkb.model = "pc105";
    xkb.options = "grp:caps_toggle,grp_led:caps,grp_led:scroll,compose:ralt";

    windowManager.i3.enable = true;
  };
  services.displayManager.sddm.enable = true;

  home-manager.users.dmitry.xsession = {
    enable = true;
    initExtra = ''
      xrdb -merge -override .Xresources
      setxkbmap -layout us,ru -option grp:caps_toggle,grp_led:caps,grp_led:scroll,compose:ralt -model pc105

      firefox &
      pasystray &
      telegram-desktop &
      thunderbird &
      '';
  };
}
