{ inputs, lib, pkgs, ... }:

let
  bifit = inputs.secrets.work.bifit;
  registry = lib.elemAt bifit.docker.registry.domains 0;
in {
  imports = [ ./mpei.nix ];

  virtualisation.docker.daemon.settings = {
    insecure-registries = bifit.docker.registry.domains;
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
    (writeShellScriptBin "update-systemd-resolved" "exec ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved \"$@\"")
    ansible
    openvpn
  ];

  home-manager.users.dmitry = {
    programs.git = {
      extraConfig = {
        "url \"ssh://git@${bifit.gitServer}:422\"".insteadOf = [ "https://${bifit.gitServer}" "git://${bifit.gitServer}" ];
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
