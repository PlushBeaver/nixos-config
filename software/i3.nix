{ lib, pkgs, ... }:

{
  home-manager.users.dmitry.xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod4";

      keybindings =
        let
          commands = rec {
            refresh = "killall -SIGUSR1 i3status";
            
            pactl = verb: param: "exec --no-startup-id pactl ${verb} @DEFAULT_SINK@ ${param} && ${refresh}";

            rofi = mode: "exec ${pkgs.rofi}/bin/rofi -show ${mode}";

            screenshot = { active ? false, selection ? false, toFile ? false, toClipboard ? false }:
              let
                given = cond: value: if cond then value else "";
                activeOption = given active "-i \$(${pkgs.xdotool}/bin/xdotool getactivewindow)";
                selectionOption = given selection "--select";
                sourceOptions = "${activeOption} ${selectionOption}";
                toClipboardOption = given toClipboard "${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
                toFileOption = given toFile "~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png";
                targetOptions = "${toFileOption} | ${toClipboardOption}";
              in "exec maim ${targetOptions} ${targetOptions}";
          };

          bindings =
            let
              mod = modifier;
              workspaces = builtins.map builtins.toString (lib.range 1 10);
              forWorkspace = mkName: mkValue:
                builtins.listToAttrs (map (ws: lib.nameValuePair (mkName ws) (mkValue ws)) workspaces);
            in {
              i3 = {
                "${mod}+Shift+c" = "reload";
                "${mod}+Shift+r" = "restart";
                "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'Exit i3?' -B 'Yes, exit i3' 'i3-msg exit'\"";
              };

              terminal = {
                "${mod}+Return" = "exec ${pkgs.rxvt-unicode}/bin/urxvt";
              };

              menu = with commands; {
                "${mod}+d" = rofi "drun";
                "${mod}+e" = rofi "run";
                "${mod}+s" = rofi "ssh";
                "${mod}+w" = rofi "window";
              };

              volume = with commands; {
                "XF86AudioRaiseVolume" = pactl "set-sink-volume" "+10%";
                "XF86AudioLowerVolume" = pactl "set-sink-volume" "-10%";
                "XF86AudioMute"        = pactl "set-sink-mute"   "toggle";
                "XF86AudioMicMute"     = pactl "set-source-mute" "toggle";
              };

              screenshot = with commands; {
                "Print"               = screenshot {                   toClipboard = true; };
                "Mod1+Print"          = screenshot { active    = true; toClipboard = true; };
                "Control+Print"       = screenshot { selection = true; toClipboard = true; };
                "Shift+Print"         = screenshot {                   toFile      = true; };
                "Shift+Mod1+Print"    = screenshot { active    = true; toFile      = true; };
                "Shift+Control+Print" = screenshot { selection = true; toFile      = true; };
              };

              workspace = {
                switching = forWorkspace 
                  (ws: "${mod}+${ws}")
                  (ws: "workspace number ${ws}");
                movement = forWorkspace
                  (ws: "${mod}+Shift+${ws}")
                  (ws: "move container to workspace number ${ws}");
              };

              windows = {
                "${mod}+Shift+q " = "kill";

                "${mod}+Left" = "focus left";
                "${mod}+Down" = "focus down";
                "${mod}+Up" = "focus up";
                "${mod}+Right" = "focus right";
                "${mod}+a" = "focus parent";

                "${mod}+Shift+Left" = "move left";
                "${mod}+Shift+Down" = "move down";
                "${mod}+Shift+Up" = "move up";
                "${mod}+Shift+Right" = "move right";

                "${mod}+f" = "fullscreen toggle";

                "${mod}+h" = "split h";
                "${mod}+v" = "split v";

                "${mod}+Shift+s" = "layout stacking";
                "${mod}+Shift+w" = "layout tabbed";
                "${mod}+Shift+h" = "layout toggle split";

                "${mod}+Shift+space" = "floating toggle";
                "${mod}+space" = "focus mode_toggle";

                "${mod}+r" = "mode resize";
              };
            };

        in with bindings; lib.mkMerge [
          i3
          windows
          workspace.switching
          workspace.movement
          terminal
          menu
          volume
          screenshot
        ];

      window.commands =
        let
          workspace = n: class: {
            criteria = { inherit class; };
            command = "move container to workspace ${toString n}";
          };
        in [
          (workspace 1 "Firefox")
          (workspace 2 "Claws-mail")
          (workspace 2 "discord")
          (workspace 2 "Liferea")
          (workspace 2 "TelegramDesktop")
        ];

      fonts = ["sans-serif 8"];
      workspaceLayout = "tabbed";

      startup = [
        { command = "${pkgs.xxkb}/bin/xxkb &"; }
      ];

      bars = [
        {
          fonts = ["iosevka 10"];
          statusCommand = "env LC_ALL=ru_RU.UTF-8 i3status";
          trayOutput = "DP-0";
        }
      ];
    };

    extraConfig = ''
      new_window normal 0
      '';
  };
}
