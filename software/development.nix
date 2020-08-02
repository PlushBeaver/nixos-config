{ pkgs, ... }:

{
  # Things I do for love (c).
  environment.systemPackages = with pkgs; [
    man-pages

    gitAndTools.gitFull
    git-secret

    cmake
    gcc
    gdb
    gnumake
    meson
    ninja

    dep
    go
    grpc
    grpcurl
    protobuf

    jetbrains.clion
    jetbrains.goland
    jetbrains.pycharm-community
    jetbrains.webstorm

    (import ./vscode.nix { inherit pkgs; })
    python37Packages.pylint
    python37Packages.rope

    ansible
    docker-compose

    pandoc
    plantuml
  ];
}
