{ config, lib, ... }:

let
  cfg = config.virtualisation.docker.daemonConfig;
in {
  options.virtualisation.docker.daemonConfig = with lib; mkOption {
    type = types.attrs;
    default = {};
  };

  config = {
    environment.etc."/docker/daemon.json".text = builtins.toJSON cfg;
  };
}
