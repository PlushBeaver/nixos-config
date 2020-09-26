{ inputs, pkgs, ... }:

{
  home-manager.users.dmitry = {
    home.stateVersion = "20.09";

    programs = {
      chromium = {
        enable = true;
      };

      firefox = {
        enable = true;
        profiles = {
          default = {
            id = 0;
            name = "default";
            path = "ydwpeoes.default";
          };
          secure = {
            id = 1;
            name = "secure";
          };
        };
      };
    };
  };
}
