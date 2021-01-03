{ inputs, lib, pkgs, ... }:

{
  home-manager.users.dmitry = {
    home.stateVersion = "20.09";

    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };

      associations.removed =
        let
          noCalibre =
            let
              mimeTypes = [
                "application/pdf"
                "application/vnd.oasis.opendocument.text"
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                "text/html"
                "text/x-markdown"
              ];
              desktopFiles = [
                "calibre-ebook-edit.desktop"
                "calibre-ebook-viewer.desktop"
                "calibre-gui.desktop"
              ];
            in
              lib.zipAttrs (map (d: lib.genAttrs mimeTypes (_: d)) desktopFiles);
        in
          noCalibre;
    };

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
