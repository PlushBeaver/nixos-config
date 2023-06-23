{ pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
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
          zxh404.vscode-proto3 = mk {
            publisher = "zxh404";
            name = "vscode-proto3";
            version = "0.5.5";
            sha256 = "sha256-Em+w3FyJLXrpVAe9N7zsHRoMcpvl+psmG1new7nA8iE=";
          };
          _42crunch.vscode-openapi = mk {
            publisher = "42crunch";
            name = "vscode-openapi";
            version = "4.15.11";
            sha256 = "sha256-T0In0lvHZfEelW2vgAZwt9wcD3RYPoB610v+9NHH8dY=";
          };
        in with vscode-extensions; [
          _42crunch.vscode-openapi
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
          ms-vscode.cmake-tools
          redhat.vscode-yaml
          timonwong.shellcheck
          trond-snekvik.simple-rst
          twxs.cmake
          vscodevim.vim
          zxh404.vscode-proto3
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
