{ ... }:

{
  systemd.services.docker = {
    requires = [ "var-lib-docker.mount" ];
    after = [ "var-lib-docker.mount" ];
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = true;
    logDriver = "json-file";
    storageDriver = "overlay2";

    daemon.settings = {
      default-address-pools = [{
        base = "172.16.0.0/12";
        size = 24;
      }];

      ipv6 = true;
      fixed-cidr-v6 = "2001:db8:1::/64";

      dns = [ "172.17.0.1" ];

      log-opts = {
        max-file = "2";
        max-size = "50m";
      };
    };
  };
}
