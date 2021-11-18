{ inputs, pkgs, ... }: {
  systemd.services.vpnc-mpei = let
    iface = "mpei";
    mpei = inputs.secrets.work.mpei;
    config = pkgs.writeText "vpnc-mpei.conf" ''
      Noninteractive
      No Detach
      IPSec gateway ipsec.mpei.ac.ru
      IPSec ID IPsecVPN
      IPSec secret mpeinet
      Domain public
      Xauth username ${mpei.username}
      Xauth password ${mpei.password}
      Interface name ${iface}
      Interface mode tun
      Script ${script}
    '';
    script = pkgs.writeShellScript "vpnc-mpei-script" ''
      #!/usr/bin/env -S sh -eu
      ${pkgs.systemd}/bin/resolvectl domain ${iface} $CISCO_DEF_DOMAIN
      ${pkgs.systemd}/bin/resolvectl dns ${iface} $INTERNAL_IP4_DNS $INTERNAL_IP6_DNS
      exec ${pkgs.vpnc}/etc/vpnc/vpnc-script
    '';
  in {
    enable = true;
    requires = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = with pkgs; [ iproute2 vpnc ];
    script = "${pkgs.vpnc}/bin/vpnc ${config}";
  };
}
