{ inputs, lib, pkgs, ... }:

let
  bifit = inputs.secrets.work.bifit;
  registry = bifit.docker.registry.domain;
in {
  imports = [ ./mpei.nix ];

  virtualisation.docker.daemon.settings = {
    insecure-registries = [ registry ];
  };

  virtualisation.oci-containers.containers."docker-veth-pair-plugin" = {
    image = "${registry}/build/docker-veth-pair-network-plugin";
    volumes = [
      "/run/docker/plugins:/run/docker/plugins"
    ];
    extraOptions = [
      "--rm"
      "--network=host"
      "--cap-add=NET_ADMIN"
    ];
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "offload-tcp" (builtins.readFile ./offload-tcp.sh))
    (writeShellScriptBin "netns-setup-reverse" (builtins.readFile ./netns-setup-reverse.sh))
    docker-compose_1
    inputs.nixpkgs-2111.legacyPackages.x86_64-linux.ansible_2_9
  ];

  home-manager.users.dmitry = {
    programs.git = {
      extraConfig = {
        "url \"ssh://git@${bifit.gitServer}:422\"".insteadOf = "https://${bifit.gitServer}";
      };

      includes =
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
  };
}
