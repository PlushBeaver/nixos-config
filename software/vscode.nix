{ pkgs, ... }:

{
  environment.systemPackages =
    with pkgs;
    let
      vscode = vscode-with-extensions.override {
        vscodeExtensions =
          let
            mk = vscode-utils.extensionFromVscodeMarketplace;
            trond-snekvik.simple-rst = mk {
              publisher = "trond-snekvik";
              name = "simple-rst";
              version = "1.5.4";
              sha256 = "sha256-W3LydBsc7rEHIcjE/0jESFS87uc1DfjuZt6lZhMiQcs=";
            };
            jinliming2.vscode-go-template = mk {
              publisher = "jinliming2";
              name = "vscode-go-template";
              version = "0.2.1";
              sha256 = "sha256-kvWaSuE4O98fXU+EKkplFI0Cfy2I7IiJ0/hXrVsk+6g=";
            };
            streetsidesoftware.code-spell-checker = mk {
              publisher = "streetsidesoftware";
              name = "code-spell-checker";
              version = "4.0.47";
              sha256 = "sha256-g9r8I909ge44JfBRm1JBHFluXr9H8zl0ERqkwoxtQaI=";
            };
            streetsidesoftware.code-spell-checker-russian = mk {
              publisher = "streetsidesoftware";
              name = "code-spell-checker-russian";
              version = "2.2.3";
              sha256 = "sha256-2sLYp6xaCo8RREK7CSWqunW56zJcKNbxHY6VHQqpi1M=";
            };
          in
          (with vscode-extensions; [
            arrterian.nix-env-selector
            eamodio.gitlens
            editorconfig.editorconfig
            golang.go
            jinliming2.vscode-go-template
            llvm-vs-code-extensions.vscode-clangd
            mesonbuild.mesonbuild
            mesonbuild.mesonbuild
            ms-azuretools.vscode-docker
            ms-python.python
            ms-python.vscode-pylance
            ms-vscode-remote.remote-ssh
            ms-vscode.cmake-tools
            redhat.vscode-yaml
            streetsidesoftware.code-spell-checker
            streetsidesoftware.code-spell-checker-russian
            timonwong.shellcheck
            trond-snekvik.simple-rst
            twxs.cmake
            vscodevim.vim
            zxh404.vscode-proto3
          ])
          ++ [
            vscode-extensions."42crunch".vscode-openapi
          ];
      };
      pythonTools = python3.withPackages (
        pkgs: with pkgs; [
          black
          pylint
          yapf
          rope
        ]
      );
    in
    [
      clang-tools # C/C++ LS
      docutils # reStructuredText LS
      gopls # Go LS
      pythonTools
      vscode
    ];
}
