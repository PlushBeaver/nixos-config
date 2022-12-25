{ inputs, ... }:

{
  environment.systemPackages =
    with inputs.nixpkgs-2205.legacyPackages.x86_64-linux;
    let
      vscode = vscode-with-extensions.override {
        vscodeExtensions = let
          mk = vscode-utils.extensionFromVscodeMarketplace;
          mesonbuild.mesonbuild = mk {
            publisher = "mesonbuild";
            name = "mesonbuild";
            version = "1.7.0";
            sha256 = "sha256-pHHPHF+y5tu0IG6hbdM1LJLlDia0cnRLLWDBBP81TnU=";
          };
          trond-snekvik.simple-rst = mk {
            publisher = "trond-snekvik";
            name = "simple-rst";
            version = "1.5.2";
            sha256 = "sha256-pV7/S8kkDIbhD2K5P2TA8E0pM4F8gsFIlc+4FIheBbc=";
          };
          jinliming2.vscode-go-template = mk {
            publisher = "jinliming2";
            name = "vscode-go-template";
            version = "0.2.1";
            sha256 = "sha256-kvWaSuE4O98fXU+EKkplFI0Cfy2I7IiJ0/hXrVsk+6g=";
          };
        in with vscode-extensions; [
          arrterian.nix-env-selector
          eamodio.gitlens
          editorconfig.editorconfig
          golang.go
          jinliming2.vscode-go-template
          llvm-vs-code-extensions.vscode-clangd
          mesonbuild.mesonbuild
          ms-azuretools.vscode-docker
          ms-python.python
          ms-python.vscode-pylance
          ms-vscode-remote.remote-ssh
          timonwong.shellcheck
          trond-snekvik.simple-rst
          vscodevim.vim
        ];
      };
      pythonTools = python3.withPackages (pkgs: with pkgs; [
        black
        pylint
        yapf
        rope
      ]);
    in [
      clang-tools_14 # C/C++ LS
      docutils # reStructuredText LS
      gopls # Go LS
      pythonTools
      vscode
    ];
}
