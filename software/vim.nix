{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (neovim.override {
      configure = {
        packages.plugins = with vimPlugins; {
          start = [
            vim-lastplace
            vim-nix
            vim-plug
          ];
          opt = [];
        };
      };

      vimAlias = true;
    })
  ];

  programs.vim.defaultEditor = true;
}
