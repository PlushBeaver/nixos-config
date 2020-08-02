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
          version = "1.2.0";
          sha256 = "0y6x4icwywizdid3zmz9vprvnjjbxjr0fgz4n1bgskkjygh31s9n";
        }

        { name = "ninja";
          publisher = "surajbarkale";
          version = "0.0.1";
          sha256 = "0qaym9p079m6m40s7py3vm3fx8bhi1pna7d84qrmj9s4mx95862d";
        }

        { name = "cmake-integration-vscode";
          publisher = "go2sh";
          version = "0.7.1";
          sha256 = "0hzp4jwlam1dl9mhgnlbvjbhvsrzv02pcafl6imab12df42ln12q";
        }

        { name = "gitlens";
          publisher = "eamodio";
          version = "10.2.1";
          sha256 = "1bh6ws20yi757b4im5aa6zcjmsgdqxvr1rg86kfa638cd5ad1f97";
        }

        { name = "vscode-openapi";
          publisher = "42Crunch";
          version = "3.2.0";
          sha256 = "0sc2j79j6k88k1swr484zbfdb862w7glqhlnzias13mpa773j2a1";
        }

        { name = "vscode-yaml";
          publisher = "redhat";
          version = "0.8.0";
          sha256 = "08dy5wm24c3bga698925pjwbymdmxi00a84d6xajj750pax7grz0";
        }

        { name = "Nix";
          publisher = "bbenoist";
          version = "1.0.1";
          sha256 = "ab0c6a386b9b9507953f6aab2c5f789dd5ff05ef6864e9fe64c0855f5cb2a07d";
        }
      ];
    in packaged ++ local;
})
