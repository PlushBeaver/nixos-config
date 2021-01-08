{ pkgs, ... }:

with pkgs; (vscode-with-extensions.override {
  vscodeExtensions =
    let
      packaged = with vscode-extensions; [
        ms-vscode.cpptools
        ms-python.python
      ];

      local = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        { name = "meson";
          publisher = "asabil";
          version = "1.3.0";
          sha256 = "sha256-QMp3dEFx6Mu5pgzklylW6b/ugYbtbT/qz8IeeuzPZeA=";
        }

        { name = "cmake-integration-vscode";
          publisher = "go2sh";
          version = "0.7.1";
          sha256 = "0hzp4jwlam1dl9mhgnlbvjbhvsrzv02pcafl6imab12df42ln12q";
        }

        { name = "gitlens";
          publisher = "eamodio";
          version = "11.1.3";
          sha256 = "sha256-hqJg3jP4bbXU4qSJOjeKfjkPx61yPDMsQdSUVZObK/U=";
        }

        { name = "nix-ide";
          publisher = "jnoortheen";
          version = "0.1.7";
          sha256 = "sha256-NXMwd1Yi6kVxXLhWgzFOXQm580Mv4UPh6jUulbDnhK8=";
        }

        { name = "nix-env-selector";
          publisher = "arrterian";
          version = "0.1.2";
          sha256 = "sha256-aTNxr1saUaN9I82UYCDsQvH9UBWjue/BSnUmMQOnsdg=";
        }

        { name = "Go";
          publisher = "golang";
          version = "0.20.1";
          sha256 = "sha256-UjGaePjYceLdkf2yrxkVy6ht2aStJ5wklguKe/Z8HUI=";
        }

        { name = "go-group-imports";
          publisher = "aleksandra";
          version = "1.1.3";
          sha256 = "sha256-G8Z2Twe6dFe2fE2KUOb2FmzW0iagRsjxERQZI0vJqSs=";
        }
      ];
    in packaged ++ local;
})
