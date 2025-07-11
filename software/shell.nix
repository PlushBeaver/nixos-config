{ ... }: {
  home-manager.users."dmitry" = {
    home.shellAliases = {
      "dc" = "docker compose";
      "gco" = "git checkout";
      "gf" = "git fetch";
      "gl" = "git pull";
      "glol" = "git log --graph --oneline --format='format:%C(auto)%h %C(cyan)%cs %C(auto)%s%d'";
      "glola" = "git log --all --graph --oneline --format='format:%C(auto)%h %C(cyan)%cs %C(auto)%s%d'";
      "gst" = "git status";
      "gsta" = "git stash save";
      "gstp" = "git stash pop";
      "nsh" = "nix-shell --command $SHELL";
    };

    programs = {
      powerline-go = {
        enable = true;
        modules = [ "time" "cwd" "gitlite" ];
        newline = true;
        settings = {
          mode = "flat";
          cwd-mode = "plain";
        };
      };

      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableVteIntegration = true;
        autocd = true;
        history.extended = true;
        initContent = "unset RPROMPT";
        prezto = {
          enable = true;
          pmodules = [
            "utility"  # must come before "completion"
            "completion"
            "docker"
            "editor"
            "environment"
            "history"
            "history-substring-search"
            "prompt"
            "terminal"
          ];
        };
      };
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];
}
