{ inputs, ... }:

let
  bifit = inputs.secrets.work.bifit;
  docker = bifit.docker.registry;
in {
  services.dnsmasq = {
    enable = true;
    servers = bifit.dnsServers;
  };

  environment.etc."/docker/certs.d/${docker.domain}/ca.crt".text = docker.rootCA;

  docker-containers."docker-veth-pair-plugin" = {
    image = "${docker.domain}/build/docker-veth-pair-network-plugin";
    volumes = [
      "/run/docker/plugins:/run/docker/plugins"
    ];
    extraDockerOptions = [
      "--rm"
      "--network=host"
      "--cap-add=NET_ADMIN"
    ];
  };
}
