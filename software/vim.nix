{ pkgs, ... }:

{
  programs.vim.defaultEditor = true;

  home-manager.users.dmitry.programs.neovim =
    let
      ledger-plugin = pkgs.vimUtils.buildVimPlugin {
        name = "vim-ledger";
        src = pkgs.fetchFromGitHub {
          owner = "ledger";
          repo = "vim-ledger";
          rev = "d5f2af4883351aa437ca1c3157d21917dc2bb1b0";
          sha256 = "mZeFTga6hzDbLHYjn5BkPLM+t3LNaf0IGtorutSCvi0=";
        };
      };
    in {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        airline
        nerdtree

        fugitive
        gitgutter

        nerdcommenter
        surround

        vim-markdown
        vim-move
        vim-nix
        vim-pandoc
        vim-pandoc-syntax

        ledger-plugin
      ];

      extraConfig = builtins.readFile ../config/init.vim;
    };
}
