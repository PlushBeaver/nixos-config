{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    liveRestore = true;
    logDriver = "json-file";
    storageDriver = "btrfs";

    daemonConfig = {
      default-address-pools = [
        {
          base = "172.16.0.0/12";
          size = 24;
        }
      ];

      ipv6 = true;
      fixed-cidr-v6 = "2001:db8:1::/64";

      dns = ["172.17.0.1"];

      log-opts = {
        max-file = "2";
        max-size = "50m";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  systemd.services."docker-dns-proxy" = {
    script = "${pkgs.socat}/bin/socat -T5 UDP-LISTEN:53,fork,reuseaddr,bind=172.17.0.1 UDP:127.0.0.53:53";
    wantedBy = ["docker.service"];
    after = ["docker.service"];
  };
}
