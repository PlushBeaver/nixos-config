{ pkgs, ... }:

{
  imports = [ ./vscode.nix ];

  # Things I do for love (c).
  environment.systemPackages = with pkgs; [
    man-pages
    posix_man_pages
    moreutils
    openssl

    git-crypt

    gcc
    gdb

    go
    grpcurl
    protobuf

    (python3.withPackages (pkgs: [pkgs.tkinter]))

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
      aliases = {
        wipe = "!temp() { if [ -z \"$1\" ]; then exit 1; fi; git branch -D $1; git push origin :$1; }; temp";
      };
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
