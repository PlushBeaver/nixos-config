{ ... }:

{
  imports = [
    ./home-manager.nix
    ./network.nix
    ./users.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MONETARY = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
      LC_CALENDAR = "ru_RU.UTF-8";
    };
  };

  services.journald.extraConfig = ''
    Storage=volatile
    SystemMaxUse=64M
    RuntimeMaxUse=64M
    '';

  services.xserver = {
    enable = true;

    videoDrivers = ["nvidia"];

    layout = "us,ru";
    xkbOptions = "grp:caps_toggle,grp_led:caps,grp_led:scroll,compose:ralt";

    startDbusSession = true;

    displayManager.sddm.enable = true;
    windowManager.i3.enable = true;
  };

  time.timeZone = "Europe/Moscow";
}
