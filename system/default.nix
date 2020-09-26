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

  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MONETARY = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
      LC_CALENDAR = "ru_RU.UTF-8";
    };
  };

  services.devmon.enable = true;

  services.journald.extraConfig = ''
    Storage=volatile
    SystemMaxUse=64M
    RuntimeMaxUse=64M
    '';
}
