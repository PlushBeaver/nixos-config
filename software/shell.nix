{ ... }: {
  home-manager.users."dmitry" = {
    home.shellAliases = {
      "dc" = "docker compose";
      "gco" = "git checkout";
      "gf" = "git fetch";
      "gl" = "git pull";
      "glol" = "git log --graph --oneline --decorate";
      "glola" = "git log --graph --oneline --decorate --all";
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
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;
        enableVteIntegration = true;
        autocd = true;
        history.extended = true;
        initExtra = "unset RPROMPT";
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
