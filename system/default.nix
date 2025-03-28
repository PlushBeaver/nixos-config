{ pkgs, ... }:

let
  nicReloadScript = pkgs.writeScriptBin "nic-reload" ''
    #!${pkgs.stdenv.shell}
    echo 1 > /sys/bus/pci/devices/0000:04:04.0/remove
    echo 1 > /sys/bus/pci/devices/0000:05:05.0/remove
    sleep 1
    echo 1 > /sys/bus/pci/rescan
  '';
in {
  imports = [
    ./home-manager.nix
    ./network.nix
    ./users.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  services.timesyncd.servers = [
    "0.ru.pool.ntp.org"
    "1.ru.pool.ntp.org"
    "2.ru.pool.ntp.org"
    "3.ru.pool.ntp.org"
  ];
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

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.journald.extraConfig = ''
    Storage=volatile
    SystemMaxUse=64M
    RuntimeMaxUse=64M
    '';

  environment.systemPackages = [ nicReloadScript ];
}
