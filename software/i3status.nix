{ lib, ... }:

{
  # TODO: generate positions in home-manager modules,
  #       move "bifit" interface status to work configuration.
  home-manager.users.dmitry.programs.i3status = 
    let
      span = color: text:
        "<span color='${color}'>${text}</span>";

      ethernet = name: device: {
        "ethernet ${device}" = {
          settings = {
            format_up = "${span "#aaa" "${name}:"} %ip";
            format_down = "${span "#aaa" "${name}:"} down";
          };
        };
      };

      disk = path: {
        "disk ${path}".settings.format = "${span "#aaa" "${path}"} %avail ${span "#222" "of"} ${span "#666" "%total"}";
      };

      load = {
        "load".settings.format = "${span "#aaa" "CPU:"} %1min";
      };

      memory = {
        "memory".settings = {
          format = "${span "#aaa" "Used:"} %used";
          format_degraded = "${span "#aaa" "Free:"} %free";
        };
      };

      time = {
        "tztime local".settings.format = "%A %Y-%m-%d %H:%M:%S";
      };

      withPositions = lib.imap1 (i: lib.mapAttrs (_: v: v // { position = i; }));

    in {
      enable = true;
      enableDefault = false;
      general = {
        markup = "pango";
        interval = 5;
      };
      modules = lib.mkMerge (withPositions [
        (disk "/")
        (ethernet "IP" "enp5s5")
        (ethernet "VPN" "tun0")
        (ethernet "BIFIT" "bifit")
        (ethernet "MPEI" "mpei")
        load
        memory
        time
      ]);
  };
}
