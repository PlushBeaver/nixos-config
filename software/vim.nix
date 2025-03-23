{ pkgs, ... }:

{
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

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
      yang-plugin = pkgs.vimUtils.buildVimPlugin {
        name = "vim-yang";
        src = pkgs.fetchFromGitHub {
          owner = "nathanalderson";
          repo = "yang.vim";
          rev = "0edaeb616be8f66caed2c888095446006fd4a6fa";
          sha256 = "sha256-LI+Iysw7BfKviRTURyaswzS1xd4DDd0baIXTwZDJALY=";
        };
      };
    in {
      enable = true;
      defaultEditor = true;

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
        yang-plugin
      ];

      extraConfig = builtins.readFile ../config/init.vim;
    };
}
