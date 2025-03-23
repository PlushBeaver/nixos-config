{ lib, pkgs, ... }: {
  home-manager.users.dmitry = {
    programs.git = {
      includes =
        let
          dirs = [
            "~/mpei/"
          ];
          user = {
            email = "KozliukDA@mpei.ru";
            name = "Дмитрий Козлюк";
          };
        in
          lib.forEach dirs (dir: {
            condition = "gitdir:${dir}";
            contents = { inherit user; };
          });
    };
  };
}
