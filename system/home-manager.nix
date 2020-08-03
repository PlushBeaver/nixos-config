{ inputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.users.dmitry = {
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
