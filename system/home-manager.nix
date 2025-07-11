{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  home-manager.backupFileExtension = "backup";
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

    home.sessionVariables = {
      BUILDKIT_NO_CLIENT_TOKEN = "true";
    };

    programs = {
      chromium.enable = true;

      thunderbird = {
        enable = true;
        profiles.default.isDefault = true;
      };

      firefox = {
        enable = true;
        package =
          let
            inherit (lib) concatStringsSep escapeShellArg mapAttrsToList;
            env = {
              MOZ_WEBRENDER = 1;
              # Required for hardware video decoding.
              # See https://github.com/elFarto/nvidia-vaapi-driver?tab=readme-ov-file#firefox
              MOZ_DISABLE_RDD_SANDBOX = 1;
              LIBVA_DRIVER_NAME = "nvidia";
              NVD_BACKEND = "direct";
            };
            envStr = concatStringsSep " " (mapAttrsToList (n: v: "${n}=${escapeShellArg v}") env);
          in
          pkgs.firefox.overrideAttrs (old: {
            buildCommand =
              old.buildCommand
              + ''
                substituteInPlace $out/bin/firefox \
                  --replace "exec -a" ${escapeShellArg envStr}" exec -a"
              '';
          });
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
