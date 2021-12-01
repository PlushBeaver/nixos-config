{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [
      (vscode-with-extensions.override {
        vscodeExtensions = let
          packaged = with vscode-extensions; [
            ms-azuretools.vscode-docker
            ms-python.python
            ms-vscode-remote.remote-ssh
            ms-vscode.cpptools
            vscodevim.vim
            golang.go
          ];

          local = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "meson";
              publisher = "asabil";
              version = "1.3.0";
              sha256 = "sha256-QMp3dEFx6Mu5pgzklylW6b/ugYbtbT/qz8IeeuzPZeA=";
            }

            {
              publisher = "ms-vscode";
              name = "cmake-tools";
              version = "1.6.0";
              sha256 = "sha256-vI36GI1J21T5Lg5YBm8zfyvgi0kYDwG2wCmXRT83a8g=";
            }

            {
              name = "gitlens";
              publisher = "eamodio";
              version = "10.2.1";
              sha256 = "1bh6ws20yi757b4im5aa6zcjmsgdqxvr1rg86kfa638cd5ad1f97";
            }

            {
              name = "nix-ide";
              publisher = "jnoortheen";
              version = "0.1.7";
              sha256 = "sha256-NXMwd1Yi6kVxXLhWgzFOXQm580Mv4UPh6jUulbDnhK8=";
            }

            {
              name = "nix-env-selector";
              publisher = "arrterian";
              version = "0.1.2";
              sha256 = "sha256-aTNxr1saUaN9I82UYCDsQvH9UBWjue/BSnUmMQOnsdg=";
            }

            {
              name = "go-group-imports";
              publisher = "aleksandra";
              version = "1.1.3";
              sha256 = "sha256-G8Z2Twe6dFe2fE2KUOb2FmzW0iagRsjxERQZI0vJqSs=";
            }

            {
              name = "restructuredtext";
              publisher = "lextudio";
              version = "143.0.0";
              sha256 = "sha256-RUxdbSn3zhesFyCbaLpd9fHM9bLqOrVX1sPh2cabPmM=";
            }
          ];
        in packaged ++ local;
      })
    ];
}
