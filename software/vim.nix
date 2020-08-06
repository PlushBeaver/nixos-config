{ pkgs, ... }:

{
  programs.vim.defaultEditor = true;

  home-manager.users.dmitry.programs.neovim = {
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
    ];

    extraConfig = builtins.readFile ../config/init.vim;
  };
}
