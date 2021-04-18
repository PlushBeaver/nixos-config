{ pkgs, ... }:

{
  imports = [ ./vscode.nix ];

  # Things I do for love (c).
  environment.systemPackages = with pkgs; [
    man-pages
    posix_man_pages
    moreutils

    git-crypt

    cmake
    gcc
    gdb
    gnumake
    meson
    ninja

    easyjson
    go
    go-swagger
    grpc
    grpcurl
    protobuf

    jetbrains.goland

    python3
    python37Packages.pylint
    python37Packages.rope

    ansible_2_9
    docker-compose

    nixfmt

    pandoc
    plantuml
  ];

  home-manager.users.dmitry = {
    # TODO: https://github.com/dandavison/delta maybe?
    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      ignores = ["/result"];
      userName = "Dmitry Kozlyuk";
      userEmail = "dmitry.kozliuk@gmail.com";
      extraConfig = {
        core = {
          autocrlf = "input";
          quotePath = false;
        };
        sendemail = {
          smtpEncryption = "tls";
          smtpServer = "smtp.gmail.com";
          smtpUser = "dmitry.kozliuk@gmail.com";
          smtpServerPort = 587;
        };
      };
    };
  };
}
