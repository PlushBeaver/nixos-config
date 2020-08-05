{ inputs, lib, pkgs, ... }:

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

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "offload-tcp" (builtins.readFile ./offload-tcp.sh))
    (writeShellScriptBin "netns-setup-reverse" (builtins.readFile ./netns-setup-reverse.sh))
  ];

  home-manager.users.dmitry = {
    programs.git.includes =
      let
        dirs = [
          "~/work/"
          "~/go/src/${bifit.gitServer}/"
        ];
        user = {
          email = "kozlyuk@bifit.com";
          name = "Dmitry Kozlyuk";
        };
      in
        lib.forEach dirs (dir: {
          condition = "gitdir:${dir}";
          contents = { inherit user; };
        });
  };
}
